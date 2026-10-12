import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repos/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_home_products_state.dart';

class FetchHomeProductsCubit extends Cubit<FetchHomeProductsState> {
  FetchHomeProductsCubit({required this._homeRepo}) : super(FetchHomeProductsInitial());
  final HomeRepo _homeRepo;

  static const int _pageSize = 10;

  final List<ProductModel> _products = [];
  int _nextPageOffset = 0;
  bool _hasReachedMax = false;
  bool _isFetching = false;

  /// أول تحميل (أو Refresh)
  Future<void> fetchHomeProducts() async {
    _products.clear();
    _nextPageOffset = 0;
    _hasReachedMax = false;
    emit(FetchHomeProductsLoading());
    await _fetchPage();
  }

  Future<void> _fetchPage() async {
    _isFetching = true;
    final result = await _homeRepo.fetchHomeProducts(offset: _nextPageOffset);
    _isFetching = false;

    result.fold(
      (error) {
        if (_products.isEmpty) {
          emit(FetchHomeProductsFailure(errorMessage: error.message));
        } else {
          emit(
            FetchHomeProductsLoadMoreFailure(
              products: List.unmodifiable(_products),
              errorMessage: error.message,
            ),
          );
        }
      },
      (newProducts) {
        if (newProducts.length < _pageSize) {
          _hasReachedMax = true;
        }
        _products.addAll(newProducts);
        _nextPageOffset += newProducts.length;
        emit(
          FetchHomeProductsSuccess(products: List.unmodifiable(_products), hasReachedMax: _hasReachedMax),
        );
      },
    );
  }

  /// جلب الصفحة اللي بعد كده
  Future<void> fetchNextPage() async {
    if (_isFetching || _hasReachedMax) return;
    emit(FetchHomeProductsLoadingMore(products: List.unmodifiable(_products)));
    await _fetchPage();
  }
}
