
import 'package:ecommerce_app_huma_volve/core/di/dependency_injection.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repos/home_repo.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubits/fetch_homme_books/fetch_home_products_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/views/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/theme.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body:BlocProvider(
           create: (context) =>
            FetchHomeProductsCubit(homeRepo: getIt<HomeRepo>())..fetchHomeProducts(),
        child: HomeViewBody(),
      ),
    );
  }
}
