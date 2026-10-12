part of 'fetch_home_products_cubit.dart';

@immutable
sealed class FetchHomeProductsState {}

final class FetchHomeProductsInitial extends FetchHomeProductsState {}

final class  FetchHomeProductsLoading extends FetchHomeProductsState {}

final class FetchHomeProductsSuccess extends FetchHomeProductsState {
  final List<ProductModel> products;
  final bool hasReachedMax;
  FetchHomeProductsSuccess({required this.products, required this.hasReachedMax});
}

final class FetchHomeProductsLoadingMore extends FetchHomeProductsState {
  final List<ProductModel> products;
  
  FetchHomeProductsLoadingMore({required this.products});
}

final class FetchHomeProductsLoadMoreFailure extends FetchHomeProductsState {
  final List<ProductModel> products;
  final String errorMessage;
  FetchHomeProductsLoadMoreFailure({required this.products, required this.errorMessage});
}

final class FetchHomeProductsFailure extends FetchHomeProductsState {
  final String errorMessage;
  FetchHomeProductsFailure({required this.errorMessage});
}
