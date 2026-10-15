import 'package:ecommerce_app_huma_volve/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnFilterChanged = void Function(String value);

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key, required this.onCategoryChanged});
  final OnFilterChanged onCategoryChanged;

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  int selectedIndex = 0;

  static const _tabs = ['All', 'Shoes', 'Clothing', 'Accessories', 'Electronics'];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _tabs.length,
      separatorBuilder: (context, index) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final isSelected = selectedIndex == index;
        return GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            setState(() {
              selectedIndex = index;
            });
            widget.onCategoryChanged(_tabs[index]);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primary : Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                if (!isSelected)
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.05),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                if (isSelected)
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Text(
              _tabs[index],
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
