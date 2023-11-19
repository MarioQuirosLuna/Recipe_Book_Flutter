import 'package:http/http.dart' as http;

import '../domain/entities/Categories.dart';

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
}