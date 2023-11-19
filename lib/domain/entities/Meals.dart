
import 'dart:convert';
import 'MealDetails.dart';

Meals mealsFromJson(String str) => Meals.fromJson(json.decode(str));

String mealsToJson(Meals data) => json.encode(data.toJson());

class Meals {
  final List<MealDetail> meals;

  Meals({
    required this.meals
  });

  factory Meals.fromJson(Map<String, dynamic> json) => Meals (
    meals: List<MealDetail>.from(json["meals"].map((x) => MealDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
  };
}