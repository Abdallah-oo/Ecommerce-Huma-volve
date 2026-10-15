import 'package:ecommerce_app_huma_volve/core/themes/theme.dart';
import 'package:flutter/material.dart';

typedef OnFilterChanged = void Function(String value);

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key, required this.onQueryChanged});
  final OnFilterChanged onQueryChanged;

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      onChanged: (value) => widget.onQueryChanged(value),
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search clothes...',
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.tune, color: Colors.white, size: 20),
        ),
        border: InputBorder.none,
      ),
    );
  }
}
