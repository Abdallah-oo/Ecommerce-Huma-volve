import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_client.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_exceptions.dart';

class ApiService {
  final DioClient dioClient;
  ApiService(this.dioClient);

  //CRUDE METHODS

  ///get
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await dioClient.dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      throw DioExceptions.handleError(e);
    }
  }

  ///post
  Future<dynamic> post(String endpoint, dynamic body) async {
    try {
      final response = await dioClient.dio.post(endpoint, data: body);

      return response;
    } on DioException catch (e) {
      throw DioExceptions.handleError(e);
    }
  }

  //put
  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await dioClient.dio.put(endpoint, data: body);
      return response;
    } on DioException catch (e) {
      throw DioExceptions.handleError(e);
    }
  }

  ///delete
  Future<dynamic> delete(String endpoint, Map<String, dynamic> body, {dynamic params}) async {
    try {
      final response = await dioClient.dio.delete(endpoint, data: body, queryParameters: params);
      return response;
    } on DioException catch (e) {
      throw DioExceptions.handleError(e);
    }
  }
}
