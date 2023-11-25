import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/app_theme.dart';
import '../../provider/recipe_book_provider.dart';

class IngredientForMealView extends StatelessWidget {
  const IngredientForMealView({
    super.key,
    required this.recipeProvider,
  });

  final RecipeBookProvider recipeProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipeProvider.mealDetailsIngredients.length + 1,
      itemBuilder: (context, index) {
        if(index == 0){
          return ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text(
              "Ingredients For",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
                "1 Serving",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ), //TODO: Add servings or Remove servings and recalculate measures
          );
        }
        final ingredientIndex = index - 1;
        return ListTile(
          leading: Image.network(
            recipeProvider.mealDetailsIngredients[ingredientIndex].image,
            width: 50,
            height: 50,
          ),
          title: Text(
            recipeProvider.mealDetailsIngredients[ingredientIndex].name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            recipeProvider.mealDetailsIngredients[ingredientIndex].measure,
          ),
        );
      },
    );
  }
}