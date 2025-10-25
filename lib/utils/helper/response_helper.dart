import 'package:dio/dio.dart';

abstract class ResponseChecker {
  static Map<String, dynamic> getSuccessData({
    required Response? response,
    int statusCode = 200,
  }) {
    if (response == null || response.statusCode != statusCode || response.data == null) {
      throw Exception('Null response or incorrect status code.');
    }

    Map<String, dynamic> data = {};

    if (response.data is Map<String, dynamic>) {
      data = response.data as Map<String, dynamic>;
    }

    if (data['success'] != true) {
      throw Exception('Response failed.');
    }

    if (data['data'] == null) {
      throw Exception('Response data null.');
    }

    return data['data'];
  }
}