import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_Screen.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/filter_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedScreen = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  // void _showInfoMessage(String message) {}

  // void toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = favoriteMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal is no longer a favorite .');
  //   } else {
  //     setState(() {
  //       favoriteMeals.add(meal);
  //       _showInfoMessage('is favorite');
  //     });
  //   }
  // }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    var activeTitle = 'Category';

    if (_selectedScreen == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);

      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activeTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: Drawer(
        child: MainDrawer(
          onSelectScreen: _setScreen,
        ),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedScreen,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
