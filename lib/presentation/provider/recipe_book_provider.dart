import 'package:flutter/cupertino.dart';
import 'package:recipe_book_flutter/domain/entities/Categories.dart';
import 'package:recipe_book_flutter/domain/entities/ListMealDetails.dart';
import 'package:recipe_book_flutter/domain/entities/MealByCategory.dart';
import 'package:recipe_book_flutter/domain/entities/MealDetail.dart';

import '../../data/Recipes_Http_Service.dart';

class RecipeBookProvider extends ChangeNotifier {
  Categories? _categories;
  ListMealDetails? _todayPicks;
  MealsByCategory? _mealsByCategory;
  MealDetails? _mealDetails;

  Categories? get categories => _categories;
  ListMealDetails? get todayPicks => _todayPicks;
  MealsByCategory? get mealsByCategory => _mealsByCategory;
  MealDetails? get mealDetails => _mealDetails;

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

  Future<void> loadMealDetails(String id) async {
    print("Loading meal details $id");
    _mealDetails = null;
    _mealDetails = await _recipesHttpService.getFullMealById(id);
    notifyListeners();
  }
}