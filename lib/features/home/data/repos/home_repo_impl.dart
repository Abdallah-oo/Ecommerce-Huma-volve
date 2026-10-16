import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/constances/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_error.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_service.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_exceptions.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;
  HomeRepoImpl({required this.apiService});
  @override
  Future<Either<ApiError, List<ProductModel>>> fetchHomeProducts({required int offset}) async {
    try {
      final response = await apiService.get(
        endpoint: ApiEndpoints.products,
        queryParameters: {'limit': 10, 'startIndex': offset},
      );

      final List<ProductModel> products = (response.data as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();

      return Right(products);
    } on DioException catch (e) {
      return left(DioExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, ProductModel>> getProductById({required String id}) async {
    try {
      final response = await apiService.get(
        endpoint: ApiEndpoints.products,
        queryParameters: {'id': id},
      );
      return Right(ProductModel.fromJson(response.data[0]));
    } on DioException catch (e) {
        print(
        'DIO TYPE: ${e.type} | MSG: ${e.message} | ERR: ${e.error} | URL: ${e.requestOptions.uri}',
      );

      return left(DioExceptions.handleError(e));
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
