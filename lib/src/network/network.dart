import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Network {
  static Dio dio(String baseUrl, {int connectTimeout = 60 * 1000}) =>
      Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: connectTimeout))
        ..interceptors.addAll([
          PrettyDioLogger(requestBody: true, responseHeader: true),
        ]);
}
