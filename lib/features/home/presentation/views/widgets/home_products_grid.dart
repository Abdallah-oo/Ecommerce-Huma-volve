import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubits/fetch_homme_books/fetch_home_products_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/views/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeProductsGrid extends StatelessWidget {
  const HomeProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchHomeProductsCubit, FetchHomeProductsState>(
      builder: (context, state) {
        final cubit = context.read<FetchHomeProductsCubit>();

        if (state is FetchHomeProductsLoading || state is FetchHomeProductsInitial) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is FetchHomeProductsFailure) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                    const SizedBox(height: 12),
                    Text(state.errorMessage, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(onPressed: cubit.fetchHomeProducts, child: const Text('Retry')),
                  ],
                ),
              ),
            ),
          );
        }

        final List<ProductModel> products;

        if (state is FetchHomeProductsSuccess) {
          products = state.products;
        } else if (state is FetchHomeProductsLoadingMore) {
          products = state.products;
        } else if (state is FetchHomeProductsLoadMoreFailure) {
          products = state.products;
        } else {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        final isLoadingMore = state is FetchHomeProductsLoadingMore;
        final hasLoadMoreFailure = state is FetchHomeProductsLoadMoreFailure;

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index < products.length) {
                return ProductCard(product: products[index]);
              }

              if (isLoadingMore) {
                return const Center(child: CircularProgressIndicator());
              }

              if (hasLoadMoreFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.redAccent),
                      const SizedBox(height: 8),
                      Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      TextButton(onPressed: cubit.fetchNextPage, child: const Text('Retry')),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            }, childCount: products.length + ((isLoadingMore || hasLoadMoreFailure) ? 1 : 0)),
          ),
        );
      },
    );
  }
}
