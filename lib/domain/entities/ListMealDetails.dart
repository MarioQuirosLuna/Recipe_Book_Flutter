
import 'dart:convert';
import 'Ingredient.dart';
import 'MealDetail.dart';

ListMealDetails mealsFromJson(String str) => ListMealDetails.fromJson(json.decode(str));

String mealsToJson(ListMealDetails data) => json.encode(data.toJson());

class ListMealDetails {
  final List<MealDetail> meals;

  ListMealDetails({
    required this.meals
  });

  factory ListMealDetails.fromJson(Map<String, dynamic> json) => ListMealDetails (
    meals: List<MealDetail>.from(json["meals"].map((x) => MealDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
  };
}