import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_flutter/domain/entities/Category.dart';

import '../../provider/recipe_book_provider.dart';
import '../../screens/Recipes/recipes_screen.dart';


class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.watch<RecipeBookProvider>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(),
          Expanded(
            child: ListView.builder(
              itemCount: recipeProvider.categories?.categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var category = recipeProvider.categories?.categories[index];
                return CardCategory(category: category);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text("Recipe Categories",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          )
      ),
    );
  }
}

class CardCategory extends StatelessWidget {
  const CardCategory({
    super.key,
    required this.category,
  });

  final Category? category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Recipes(category: category))
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1.2,
            ),
          ),
          width: 250,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(category?.strCategory ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CachedNetworkImage(
                    imageUrl: category?.strCategoryThumb ?? "",
                    placeholder: (context, url) => const Center(heightFactor: 2, child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(heightFactor: 2, child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}