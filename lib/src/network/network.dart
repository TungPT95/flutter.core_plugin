import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class Network {
  Dio _dio;

  Dio get dio => _dio;

  Network(String baseUrl, {int connectTimeout}) {
    _dio = Dio(BaseOptions(
        baseUrl: baseUrl, connectTimeout: connectTimeout ?? 60 * 1000))
      ..interceptors.addAll([
        PrettyDioLogger(requestBody: true, responseHeader: true),
      ])
      ..transformer = ResponseTransformer();
  }
}

class ResponseTransformer extends Transformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    var data = options.data ?? "";
    if (data is! String) {
      if (_isJsonMime(options.contentType)) {
        return json.encode(options.data);
      } else if (data is Map) {
        return Transformer.urlEncodeMap(data);
      }
    }
    return data.toString();
  }

  @override
  Future transformResponse(
      RequestOptions options, ResponseBody response) async {
    if (options.responseType == ResponseType.stream) {
      return response;
    }
    int length = 0;
    int received = 0;
    bool showDownloadProgress = options.onReceiveProgress != null;
    if (showDownloadProgress) {
      length = int.parse(
          response.headers[Headers.contentLengthHeader]?.first ?? "-1");
    }
    Completer completer = Completer();
    Stream stream = response.stream.transform(StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        sink.add(Uint8List.fromList(data));
        if (showDownloadProgress) {
          received += data.length;
          options.onReceiveProgress(received, length);
        }
      },
    ));
    List<int> buffer = List<int>();
    StreamSubscription subscription;
    subscription = stream.listen(
      (element) => buffer.addAll(element),
      onError: (e) => completer.completeError(e),
      onDone: () => completer.complete(),
      cancelOnError: true,
    );
    // ignore: unawaited_futures
    options.cancelToken?.whenCancel?.then((_) {
      return subscription.cancel();
    });
    if (options.receiveTimeout > 0) {
      try {
        await completer.future
            .timeout(Duration(milliseconds: options.receiveTimeout));
      } on TimeoutException {
        await subscription.cancel();
        throw DioError(
          request: options,
          error: "Receiving data timeout[${options.receiveTimeout}ms]",
          type: DioErrorType.RECEIVE_TIMEOUT,
        );
      }
    } else {
      await completer.future;
    }
    if (options.responseType == ResponseType.bytes) return buffer;
    String responseBody;
    if (options.responseDecoder != null) {
      responseBody =
          options.responseDecoder(buffer, options, response..stream = null);
    } else {
      responseBody = utf8.decode(buffer, allowMalformed: true);
    }
    if (responseBody != null &&
        responseBody.isNotEmpty &&
        options.responseType == ResponseType.json &&
        _isJsonMime(response.headers[Headers.contentTypeHeader]?.first)) {
      return json.decode(responseBody);
    } else {
      try {
        return json.decode(responseBody);
      } catch (e) {}
    }
    return responseBody;
  }

  bool _isJsonMime(String contentType) {
    if (contentType == null) return false;
    return MediaType.parse(contentType).mimeType.toLowerCase() ==
        Headers.jsonMimeType.mimeType;
  }
}
