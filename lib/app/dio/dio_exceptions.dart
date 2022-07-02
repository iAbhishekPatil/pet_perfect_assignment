import 'dart:io';

import 'package:dio/dio.dart';

abstract class DioExceptions {
  static String errorString(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        return 'Request to API server was cancelled';
      case DioErrorType.connectTimeout:
        return 'Connection timeout with API server';
      case DioErrorType.other:
        if (dioError.error is SocketException) {
          return 'Please check your internet';
        }
        return 'Something went wrong';
      case DioErrorType.receiveTimeout:
        return 'Receive timeout in connection with API server';
      case DioErrorType.response:
        return _handleError(
          dioError.response!.statusCode!,
          dioError.response!.data,
        );
      case DioErrorType.sendTimeout:
        return 'Send timeout in connection with API server';
    }
  }

  static String _handleError(int statusCode, dynamic error) {
    final responseData = error as Map<String, dynamic>;
    switch (statusCode) {
      case 400:
        return responseData['message']?.toString() ?? '400 - Bad request';
      case 404:
        return responseData['message']?.toString() ?? '404 - Not found';
      case 500:
        return '500 - Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }
}
