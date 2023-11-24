import 'package:http/http.dart' as http;
import 'package:recipe_book_flutter/domain/entities/ListMealDetails.dart';

import '../domain/entities/Categories.dart';
import '../domain/entities/MealByCategory.dart';
import '../domain/entities/MealDetail.dart';

class RecipesHttpService {
  final String _baseUrl = 'https://www.themealdb.com/api/json/v1';
  final String _apiKey = '1';

  Future<Categories> getCategories() async {
    var uri = Uri.parse('$_baseUrl/$_apiKey/categories.php');
    var response = await http.get(uri);

    if(response.statusCode == 200) {
      return categoriesFromJson(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<ListMealDetails> getTodayPicks() async {
    var uri = Uri.parse('$_baseUrl/$_apiKey/random.php');
    var response = await http.get(uri);

    if(response.statusCode == 200) {
      return mealsFromJson(response.body);
    } else {
      throw Exception('Failed to load random meal');
    }
  }

  Future<MealsByCategory> filterMealsByCategory(String categoryName) async {
    var uri = Uri.parse('$_baseUrl/$_apiKey/filter.php?c=$categoryName');
    var response = await http.get(uri);

    if(response.statusCode == 200) {
      return mealsByCategoryFromJson(response.body);
    } else {
      throw Exception('Failed to load meals by category');
    }
  }

  Future<MealDetails> getFullMealById(String id) async {
    var uri = Uri.parse('$_baseUrl/$_apiKey/lookup.php?i=$id');
    var response = await http.get(uri);

    if(response.statusCode == 200) {
      return mealDetailsFromJson(response.body);
    } else {
      throw Exception('Failed to load meal details');
    }
  }
}