import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals_Screen.dart';
import 'package:meals/widgets/categories_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCAtegory(BuildContext context, Category category) {
    final filterMeals = widget.availableMeals
        .where(
          (item) => item.categories.contains(category.id),
        )
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filterMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (ctx, child) => SlideTransition(
        position:
            //  _animationController.drive(
            Tween(
          begin: const Offset(0.5, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInCirc),
        ),
        // ),
        child: child,
      ),
      //  Padding(
      //   padding: EdgeInsets.only(
      //     top: 100 - _animationController.value * 100,
      //   ),
      //   child: child,
      // ),
      child: GridView(
        //padding for show better in screen view
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          //1-  ...availableCategories.map((item) => CategoriesItem(category: item)),
          //2- availableCategories.map((item)=>CategoriesItem(category:item)).toList(),
          // in this position(2) we have to remove children brockets
          for (final item in availableCategories)
            CategoriesItem(
              category: item,
              onSelectCategory: () => _selectCAtegory(context, item),
            ),
        ],
      ),
    );
  }
}
