// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

const BASE_URL = "https://fakestoreapi.com/";

class HttpService {
  Dio? _dio;

  static header() => {
        "Content-Type": "application/json",
      };

  init() async {
    _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: header()));
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (err, handler) {
          return handler.next(err);
        },
      ),
    );
  }

  request({
    required String url,
    required Method method,
    Map<String, dynamic>? haeder,
    Map<String, dynamic>? params,
  }) async {
    Response response;

    try {
      if (method == Method.POST) {
        response = await _dio!.post(
          url,
          data: params,
          options: Options(headers: haeder),
        );
      } else if (method == Method.DELETE) {
        response = await _dio!
            .delete(url, data: params, options: Options(headers: haeder));
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url);
      } else {
        response = await _dio!.get(
          url,
          queryParameters: params,
          options: Options(headers: haeder),
        );
      }

      // print(response.statusCode);

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something does wen't wrong");
      }
    } on SocketException {
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      print(e.message);

      throw Exception("Bad response format");
      // ignore: deprecated_member_use
    } on DioException catch (e) {
      print(e.message);

      // ignore: dead_code_on_catch_subtype
    } on DioException catch (e) {
      print(e.type);

      throw Exception("Something wen't wrong");
    }
  }
}
