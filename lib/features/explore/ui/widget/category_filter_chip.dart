import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:news_app_demo_flutter/shared/data/local/category_data.dart';
import 'package:news_app_demo_flutter/shared/domain/model/category.dart';
import 'package:news_app_demo_flutter/shared/theme/theme.dart';

class CategoryFilterChips extends StatelessWidget {
  final List<Category> categories;
  final int? selectedCategoryId;
  final ValueChanged<int> onCategorySelected;

  const CategoryFilterChips({
    super.key,
    required this.categories,
    this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: categories.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.id == selectedCategoryId;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(
                category.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onSelected: (_) => onCategorySelected(category.id),
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
              selectedColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}

@Preview(name: 'Category Filter Chips - No Selection')
Widget CategoryFilterChipsNoSelectionPreview() => MaterialApp(
    theme: NewsAppTheme.lightTheme,
    home: Scaffold(
      body: CategoryFilterChips(
        categories: CategoryData.categories,
        selectedCategoryId: 2,
        onCategorySelected: (id) {},
      ),
    ),
  );