import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/constances/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},

    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();


          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
