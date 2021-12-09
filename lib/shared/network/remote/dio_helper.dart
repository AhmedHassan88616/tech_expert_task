import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static late Dio _dio;
  static Map<String, dynamic> headers = {
    'Connection': 'keep-alive',
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*'
  };

  static init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://dashboard.roshetah.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String token = '',
  }) async {
    _dio.options.headers = headers
      ..addAll(
        {'lang': lang, 'Authorization': token},
      );
    return await _dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String token = '',
  }) async {
    _dio.options.headers = headers
      ..addAll(
        {'lang': lang, 'Authorization': token},
      );

    final response = await _dio.post(
      url,
      queryParameters: query,
      data: data,
    );
    return response;
  }


  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String token = '',
  }) async {
    _dio.options.headers = headers
      ..addAll(
        {'lang': lang, 'Authorization': token},
      );

    final response = await _dio.put(
      url,
      queryParameters: query,
      data: data,
    );
    return response;
  }
}
