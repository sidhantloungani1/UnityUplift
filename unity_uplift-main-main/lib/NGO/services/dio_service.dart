import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

// import '../utils/pref_keys.dart';

class DioService {
  static final Dio dio = Dio(); // Create a Dio instance
  
  // Helper method to set common headers
  static void _setCommonHeaders(Map<String, String>? header) {
    // String accessToken = PrefService.getString(PrefKeys.registerToken);
    header ??= {
      "Content-Type": "application/json",
      // "Authorization": accessToken,
    };
  }

  // Get API using Dio
  static Future<Response?> getApi({
    required String url,
    Map<String, String>? header,
  }) async {
    try {
      _setCommonHeaders(header);
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
      }
      return await dio.get(url, options: Options(headers: header));
    } catch (e) {
      // Handle error
      return null;
    }
  }

  // Post API using Dio
  static Future<Response?> postApi({
    required String url,
    dynamic body,
    Map<String, String>? header,
  }) async {
    try {
      _setCommonHeaders(header);
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
        print("Body => $body");
      }
      return await dio.post(url, data: body, options: Options(headers: header));
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print("=============>>>>>> ${e.toString()} <<<<<<<<=======");
      }
      return null;
    }
  }

  // Put API using Dio
  static Future<Response?> putApi({
    required String url,
    dynamic body,
    Map<String, String>? header,
  }) async {
    try {
      _setCommonHeaders(header);
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
        print("Body => $body");
      }
      return await dio.put(url, data: body, options: Options(headers: header));
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print("=============>>>>>> ${e.toString()} <<<<<<<<=======");
      }
      return null;
    }
  }

  // Delete API using Dio
  static Future<Response?> deleteApi({
    required String url,
    Map<String, String>? header,
  }) async {
    try {
      _setCommonHeaders(header);
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
      }
      return await dio.delete(url, options: Options(headers: header));
    } catch (e) {
      // Handle error
      return null;
    }
  }
}