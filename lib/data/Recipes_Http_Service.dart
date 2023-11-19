import 'package:http/http.dart' as http;
import 'package:recipe_book_flutter/domain/entities/Meals.dart';

import '../domain/entities/Categories.dart';
import '../domain/entities/Meals.dart';

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

  Future<Meals> getTodayPicks() async {
    var uri = Uri.parse('$_baseUrl/$_apiKey/random.php');
    var response = await http.get(uri);

    if(response.statusCode == 200) {
      return mealsFromJson(response.body);
    } else {
      throw Exception('Failed to load random meal');
    }
  }
}