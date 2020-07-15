import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class Network {
  Dio dio;

  Network(String baseUrl, {int connectTimeout}) {
    dio = Dio(BaseOptions(
        baseUrl: baseUrl, connectTimeout: connectTimeout ?? 60 * 1000))
      ..interceptors.addAll([
        PrettyDioLogger(requestBody: true, responseHeader: true),
      ])
      ..transformer = DefaultTransformer();
  }
}
