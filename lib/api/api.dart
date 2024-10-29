import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/global/global.dart';

class CallApi {
  static String getBaseUrl() {
    if (kDebugMode) {
      // 在调试模式下使用的基本 URL
      return 'https://api.open-meteo.com';
    } else {
      // 在 release 模式下使用的基本 URL
      return 'https://api.open-meteo.com';
    }
  }

  Future<Response> get(String endpoint, Map<String, dynamic> queryParams,
      Map<String, String> header) async {
    final String baseUrl = getBaseUrl();
    print('GET 請求: $endpoint');
    Uri uri =
        Uri.parse(baseUrl + endpoint).replace(queryParameters: queryParams);
    return _handleRequest(() => http.get(uri, headers: header));
  }

  Future<Response> post(
      String endpoint, dynamic reqBody, Map<String, String> header) async {
    final String baseUrl = getBaseUrl();
    print('POST 請求: $endpoint');
    Uri uri = Uri.parse(baseUrl + endpoint);
    final body = jsonEncode(reqBody);
    return _handleRequest(() => http.post(uri, headers: header, body: body));
  }

  Future<Response> _handleRequest(
      Future<http.Response> Function() request) async {
    try {
      final httpResponse = await request();
      log('HTTP 回傳狀態: ${httpResponse.statusCode}');

      if (httpResponse.statusCode == 200) {
        return Response.fromJson(jsonDecode(httpResponse.body));
      } else {
        throw Exception('Server Error: ${httpResponse.statusCode}');
      }
    } catch (e) {
      log('HTTP 請求失敗: $e');
      rethrow;
    }
  }

  //共用 API 請求處理邏輯
  Future<Response> handleApiCall(
    Future<Response> Function() apiCall, {
    Function()? onSuccess,
    Function()? onError,
  }) async {
    try {
      // onSuccess?.call();
      final response = await apiCall();
      onSuccess?.call();
      return response;
    } catch (e) {
      print('API 呼叫錯誤: $e');
      onError?.call();
      rethrow;
    }
  }
}
