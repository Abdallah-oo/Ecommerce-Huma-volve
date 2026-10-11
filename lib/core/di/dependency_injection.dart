import 'package:ecommerce_app_huma_volve/core/network/api_service.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/repos/auth_repo.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/repos/auth_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setUpGitIt() {
    getIt.registerSingleton<ApiService>(ApiService(DioClient()));
  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl(apiService: getIt<ApiService>()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(apiService: getIt<ApiService>()));


}
