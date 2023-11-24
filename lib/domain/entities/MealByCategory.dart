// To parse this JSON data, do
//
//     final mealsByCategory = mealsByCategoryFromJson(jsonString);

import 'dart:convert';

import 'Meal.dart';

MealsByCategory mealsByCategoryFromJson(String str) => MealsByCategory.fromJson(json.decode(str));

String mealsByCategoryToJson(MealsByCategory data) => json.encode(data.toJson());

class MealsByCategory {
  final List<Meal> meals;

  MealsByCategory({
    required this.meals,
  });

  factory MealsByCategory.fromJson(Map<String, dynamic> json) => MealsByCategory(
    meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
  };
}