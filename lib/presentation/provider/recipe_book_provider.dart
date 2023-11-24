import 'package:flutter/cupertino.dart';
import 'package:recipe_book_flutter/domain/entities/Categories.dart';
import 'package:recipe_book_flutter/domain/entities/ListMealDetails.dart';
import 'package:recipe_book_flutter/domain/entities/MealByCategory.dart';

import '../../data/Recipes_Http_Service.dart';

class RecipeBookProvider extends ChangeNotifier {
  Categories? _categories;
  ListMealDetails? _todayPicks;
  MealsByCategory? _mealsByCategory;

  Categories? get categories => _categories;
  ListMealDetails? get todayPicks => _todayPicks;
  MealsByCategory? get mealsByCategory => _mealsByCategory;

  final _recipesHttpService = RecipesHttpService();

  Future<void> loadCategories() async {
    _categories = await _recipesHttpService.getCategories();
    notifyListeners();
  }

  Future<void> loadTodayPicks() async {
    var futures = <Future<ListMealDetails>>[
      _recipesHttpService.getTodayPicks(),
      _recipesHttpService.getTodayPicks(),
      _recipesHttpService.getTodayPicks(),
    ];
    var results = await Future.wait(futures);
    _todayPicks = ListMealDetails(
      meals: [
        results[0].meals[0],
        results[1].meals[0],
        results[2].meals[0],
      ]
    );
    notifyListeners();
  }

  Future<void> loadMealsByCategory(String categoryName) async {
    _mealsByCategory = await _recipesHttpService.filterMealsByCategory(categoryName);
    notifyListeners();
  }
}