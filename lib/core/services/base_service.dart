import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mybtccanvas/core/utils/env.dart';

class BaseService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    headers: {
      'accept': '*/*',
      'Content-Type': 'application/json'
    },
    validateStatus: (status) => true, // Accept all status codes
  ));

  Future<Response> get(String endpoint) async {
    try {
      return await dio.get(endpoint);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      return await dio.post(endpoint, data: json.encode(data));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    try {
      return await dio.put(endpoint, data: data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      return await dio.delete(endpoint);
    } catch (e) {
      throw e.toString();
    }
  }
}
