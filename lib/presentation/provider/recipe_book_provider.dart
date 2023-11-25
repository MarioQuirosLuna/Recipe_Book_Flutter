import 'package:flutter/cupertino.dart';
import 'package:recipe_book_flutter/domain/entities/Categories.dart';
import 'package:recipe_book_flutter/domain/entities/ListMealDetails.dart';
import 'package:recipe_book_flutter/domain/entities/MealByCategory.dart';
import 'package:recipe_book_flutter/domain/entities/MealDetail.dart';

import '../../data/Recipes_Http_Service.dart';
import '../../domain/entities/Ingredient.dart';

class RecipeBookProvider extends ChangeNotifier {
  Categories? _categories;
  ListMealDetails? _todayPicks;
  MealsByCategory? _mealsByCategory;
  MealDetails? _mealDetails;
  List<Ingredient> _ingredients = [];
  late int _peopleAmount = 1;

  Categories? get categories => _categories;
  ListMealDetails? get todayPicks => _todayPicks;
  MealsByCategory? get mealsByCategory => _mealsByCategory;
  MealDetails? get mealDetails => _mealDetails;
  List<Ingredient> get mealDetailsIngredients => _ingredients;
  int get peopleAmount => _peopleAmount;

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
    clearMealDetails();
    _mealDetails = await _recipesHttpService.getFullMealById(id);
    _loadIngredients();
    notifyListeners();
  }

  Future<void> _loadIngredients() async {
    if(_mealDetails == null) return;

    var mealJson = _mealDetails!.meals[0].toJson();

    for (var i = 0; i < 20; i++) {
      final index = i + 1;
      final String ingredientKey = "strIngredient$index";
      final String measureKey = "strMeasure$index";

      final ingredientName = mealJson[ingredientKey];
      final ingredientMeasure = mealJson[measureKey];

      if (ingredientName != null && ingredientName.isNotEmpty) {
        String image = await _recipesHttpService.getIngredientImageSmall(ingredientName);

        _ingredients.add(Ingredient(
            name: ingredientName,
            measure: ingredientMeasure,
            image: image
        ));
      }
      notifyListeners();
    }
  }

  void setPeopleAmount(int amount) {
    _peopleAmount = amount;
    notifyListeners();
  }

  void clearMealDetails() {
    _mealDetails = null;
    _ingredients = [];
    notifyListeners();
  }
}