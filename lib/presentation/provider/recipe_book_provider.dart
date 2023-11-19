import 'package:flutter/cupertino.dart';
import 'package:recipe_book_flutter/domain/entities/Categories.dart';
import 'package:recipe_book_flutter/domain/entities/Meals.dart';

import '../../data/Recipes_Http_Service.dart';

class RecipeBookProvider extends ChangeNotifier {
  Categories? _categories;
  Meals? _todayPicks;
  Categories? get categories => _categories;
  Meals? get todayPicks => _todayPicks;

  final _recipesHttpService = RecipesHttpService();

  Future<void> loadCategories() async {
    _categories = await _recipesHttpService.getCategories();
    notifyListeners();
  }

  Future<void> loadTodayPicks() async {
    var one = await _recipesHttpService.getTodayPicks();
    var two = await _recipesHttpService.getTodayPicks();
    var three = await _recipesHttpService.getTodayPicks();
    _todayPicks = Meals(
      meals: [
        one.meals[0],
        two.meals[0],
        three.meals[0],
      ]
    );
    notifyListeners();
  }

}