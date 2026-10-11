import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_error.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/user_model.dart';


abstract class AuthRepo {
  Future<Either<ApiError,Unit >> login({required String email, required String password});
  Future<Either<ApiError, UserModel>> signup({
    required UserModel userData,

  });
  Future<Either<ApiError, UserModel>> getUserData();
  Future<Either<ApiError, bool>>checkEmailAvalibility({required String email});

}
