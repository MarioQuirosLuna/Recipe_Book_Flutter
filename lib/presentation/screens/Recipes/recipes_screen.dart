import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/Category.dart';
import '../../provider/recipe_book_provider.dart';
import '../../widgets/shared/app_bar_settings.dart';
import '../MealDetail/details_screen.dart';

class Recipes extends StatefulWidget{
  const Recipes({
    super.key,
    required this.category
  });

  final Category? category;

  @override
  RecipesState createState() => RecipesState();
}

class RecipesState extends State<Recipes> {
  late Future<void> _loadMealsByCategoryFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMealsByCategoryFuture = _loadMealsByCategory();
  }

  Future<void> _loadMealsByCategory() async {
    final recipeProvider = context.read<RecipeBookProvider>();
    await recipeProvider.loadMealsByCategory(widget.category!.strCategory);
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.watch<RecipeBookProvider>();
    return Scaffold(
      appBar: AppBarSettings(title: "Recipes",),
      body: Center(
        child: FutureBuilder<void>(
          future: _loadMealsByCategoryFuture,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }else{
              return buildGrid(recipeProvider, context);
            }
          }
        ),
      ),
    );
  }

  Expanded buildGrid(RecipeBookProvider recipeProvider, BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          for (var meal in recipeProvider.mealsByCategory!.meals)
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Details(idMeal: meal.idMeal))
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4.0)),
                        child: Image.network(
                          meal.strMealThumb,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        meal.strMeal,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}