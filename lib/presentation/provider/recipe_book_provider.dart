import 'package:flutter/cupertino.dart';
import 'package:recipe_book_flutter/domain/entities/Categories.dart';

import '../../data/Recipes_Http_Service.dart';

class RecipeBookProvider extends ChangeNotifier {
  Categories? _categories;
  Categories? get categories => _categories;

  final _recipesHttpService = RecipesHttpService();

  Future<void> loadCategories() async {
    _categories = await _recipesHttpService.getCategories();
    notifyListeners();
  }

}