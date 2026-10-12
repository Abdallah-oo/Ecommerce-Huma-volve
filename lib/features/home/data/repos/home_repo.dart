import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_error.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model/product_model.dart';

abstract interface class HomeRepo {
  Future<Either<ApiError, List<ProductModel>>> fetchHomeProducts({required int offset});
}
