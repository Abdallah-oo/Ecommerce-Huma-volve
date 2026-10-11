import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_error.dart';

class DioExceptions extends ApiError {
  DioExceptions({required super.message});
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // Try to extract a message from the response body first
    if (data is Map<String, dynamic> && data['message'] != null) {
      return ApiError(message: data['message'].toString(), statusCode: statusCode);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiError(message: 'Connection timed out. Check your network.');
      case DioExceptionType.sendTimeout:
        return const ApiError(message: 'Request timed out. Please try again.');
      case DioExceptionType.receiveTimeout:
        return const ApiError(message: 'Server took too long to respond.');
      case DioExceptionType.badResponse:
        return DioExceptions.fromResponse(
          response: error.response ?? '',
          statusCode: statusCode ?? 0,
        );
      case DioExceptionType.cancel:
        return const ApiError(message: 'Request was cancelled.');
      case DioExceptionType.connectionError:
        return const ApiError(message: 'No internet connection.');
      case DioExceptionType.badCertificate:
        return const ApiError(message: 'Certificate error. Contact support.');
      case DioExceptionType.unknown:
        return const ApiError(message: 'Something went wrong. Please try again.');
      case DioExceptionType.transformTimeout:
        return const ApiError(message: 'The server response took too long. Please try again.');
    }
  }

  factory DioExceptions.fromResponse({required dynamic response, required int statusCode}) {
    String? serverMessage;

    if (response is Response) {
      final data = response.data;

      if (data is Map<String, dynamic>) {
        serverMessage = data['message']?.toString() ?? data['error']?.toString();

        // Validation errors
        if (serverMessage == null && data['errors'] != null) {
          serverMessage = data['errors'].toString();
        }
      }
    }

    switch (statusCode) {
      case 400:
        return DioExceptions(
          message: serverMessage ?? 'Please check your information and try again.',
        );

      case 401:
        return DioExceptions(
          message: serverMessage ?? 'Your session has expired. Please sign in again.',
        );

      case 403:
        return DioExceptions(
          message: serverMessage ?? 'You do not have permission to perform this action.',
        );

      case 404:
        return DioExceptions(message: serverMessage ?? 'We couldn’t find what you’re looking for.');

      case 405:
        return DioExceptions(message: serverMessage ?? 'This action is currently unavailable.');

      case 409:
        return DioExceptions(
          message:
              serverMessage ?? 'This request could not be completed right now. Please try again.',
        );

      case 422:
        return DioExceptions(
          message: serverMessage ?? 'Please make sure all information is entered correctly.',
        );

      case 429:
        return DioExceptions(
          message: serverMessage ?? 'Too many attempts. Please wait a moment and try again.',
        );

      case 500:
        return DioExceptions(
          message: serverMessage ?? 'Something went wrong on our side. Please try again later.',
        );

      case 502:
      case 503:
        return DioExceptions(
          message:
              serverMessage ?? 'The service is temporarily unavailable. Please try again later.',
        );

      default:
        return DioExceptions(message: serverMessage ?? 'Something went wrong. Please try again.');
    }
  }
}
