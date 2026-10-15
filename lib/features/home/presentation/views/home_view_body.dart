import 'package:ecommerce_app_huma_volve/core/dummy_data.dart';
import 'package:ecommerce_app_huma_volve/core/themes/theme.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubits/fetch_homme_books/fetch_home_products_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/views/widgets/category_chip.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/views/widgets/home_products_grid.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/views/widgets/home_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late final ScrollController _scrollController;
  String _query = '';
  String _selectedTab = '';
  List<ProductModel> get items {
    List<ProductModel> items =
        context.read<FetchHomeProductsCubit>().products;

    if(_selectedTab.isNotEmpty && _selectedTab != 'All') {
      items = items.where((i) => i.category?.name == _selectedTab).toList();
    }

    if (_query.isNotEmpty) {
      items = items
          .where(
            (i) =>
                (i.title ?? '').toLowerCase().contains(_query.toLowerCase()) ||
                (i.description ?? '').toLowerCase().contains(_query.toLowerCase()),
          )
          .toList();
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = context.read<FetchHomeProductsCubit>().state;

    if (state is! FetchHomeProductsLoadingMore &&
        !(state is FetchHomeProductsSuccess && state.hasReachedMax) &&
        _scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels >= maxScroll - 300) {
        context.read<FetchHomeProductsCubit>().fetchNextPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.menu, color: AppTheme.primary),
                      ),
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(dummyUser.profilePictureUrl),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Explore',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 36),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Best trendy collection!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: HomeSearchBar(
                      onQueryChanged: (query) {
                        _query = query;
                        final cubit = context.read<FetchHomeProductsCubit>();
                        cubit.filterProducts(items);
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 44,
                    child: CategoryTabs(
                      onCategoryChanged: (category) {
                        _selectedTab = category;
                        final cubit = context.read<FetchHomeProductsCubit>();
                        cubit.filterProducts(items);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const HomeProductsGrid(),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
