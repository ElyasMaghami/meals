import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem({
    required this.category,
    required this.onSelectCategory,
    super.key,
  });
  final void Function() onSelectCategory;
  final Category category;
  void _selectedCategory() {
    onSelectCategory;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      onTap: onSelectCategory,
      child: Container(
        //padding for items text in color full box
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [
            category.color.withOpacity(0.55),
            category.color.withOpacity(0.9),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
