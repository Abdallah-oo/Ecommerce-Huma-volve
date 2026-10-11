import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/constances/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_error.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_service.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_exceptions.dart';
import 'package:ecommerce_app_huma_volve/core/utils/pref_helper.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/repos/auth_repo.dart';
import 'package:flutter/foundation.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;
  AuthRepoImpl({required this.apiService});
  @override
  Future<Either<ApiError, Unit>> login({required String email, required String password}) async {
    try {
      final response = await apiService.post(ApiEndpoints.login, {
        "email": email,
        "password": password,
      });

      final data = response.data as Map<String, dynamic>;

      final accessToken = data['access_token'];
      final refreshToken = data['refresh_token'];

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (accessToken is String &&
            accessToken.isNotEmpty &&
            refreshToken is String &&
            refreshToken.isNotEmpty) {
          await PrefHelper.saveToken(accessToken);
          await PrefHelper.saveRefreshToken(refreshToken);
          return right(unit);
        }
      }

      final errorMessage = data['message']?.toString() ?? 'Login failed';
      return left(ApiError(message: errorMessage));
    } on DioException catch (e) {
      return left(DioExceptions.handleError(e));
    } catch (e) {
      if (kDebugMode) debugPrint('login error: $e');
      return left(ApiError(message: "$e"));
    }
  }

  @override
  Future<Either<ApiError, UserModel>> signup({required UserModel userData}) async {
    try {
      final response = await apiService.post(ApiEndpoints.users, {
        "name": userData.name,
        "email": userData.email,
        "password": userData.password,
        "avatar": userData.avatar,
      });
      final Map<String, dynamic>? data = response.data as Map<String, dynamic>;

      final code = response.statusCode;

      if (code != 200 && code != 201 || data == null) {
        final message = data!['message']?.toString() ?? 'Signup failed';
        return left(ApiError(message: message));
      }


        final userdata = UserModel.fromJson(data);
        return right(userdata);

    } on DioException catch (e) {
      return left(DioExceptions.handleError(e));
    } catch (e) {
      return left(ApiError(message: "$e"));
    }
  }

  @override
  Future<Either<ApiError, UserModel>> getUserData() {
    // TODO: implement getUserData
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiError, bool>> checkEmailAvalibility({required String email})async {
    try {
      final response = await apiService.post(ApiEndpoints.checkEmail,  {
        "email": email
      });

      final data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final isAvailable = data['isAvailable'] as bool?;
        if (isAvailable != null) {
          return right(isAvailable);
        }
      }

      final errorMessage = data['message']?.toString() ?? 'Email availability check failed';
      return left(ApiError(message: errorMessage));
    } on DioException catch (e) {
      return left(DioExceptions.handleError(e));
    } catch (e) {
      if (kDebugMode) debugPrint('checkEmailAvailability error: $e');
      return left(ApiError(message: "$e"));
    }

  }

}
