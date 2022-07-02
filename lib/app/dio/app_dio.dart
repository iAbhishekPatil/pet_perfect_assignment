import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

abstract class AppDio {
  static final _dio = _getDio();
  static Dio get instance => _dio;

  static const _loggerName = 'AppDio';

  static Dio _getDio() {
    // auth dio object
    final options = BaseOptions(
      // 401 response is valid for ease of token expire
      validateStatus: (status) => (status ?? -1) >= 200 && (status ?? -1) < 300,
    );

    final interceptor = InterceptorsWrapper(
      onRequest: (request, handler) async {
        log('🌎 🌎 🌎 🌎 🌎 🌎 # API # 🌎 🌎 🌎 🌎 🌎 🌎');
        log(
          '${request.uri} || ${request.headers} || ${request.data}',
          name: _loggerName,
        );
        handler.next(request);
      },
      onResponse: (response, handler) {
        log('💀 💀 💀 💀 💀 * RESPONSE * 💀 💀 💀 💀 💀');
        log(
          '${response.statusCode} | ${json.encode(response.data)}',
          name: _loggerName,
        );
        handler.next(response);
      },
      onError: (error, handler) {
        log(
          '🚨 🚨 🚨 🚨 🚨 ERROR-TYPE: ${error.type} 🚨 🚨 🚨 🚨 🚨',
          error: error.error,
          name: _loggerName,
        );
        handler.next(error);
      },
    );
    return Dio(options)..interceptors.add(interceptor);
  }
}
