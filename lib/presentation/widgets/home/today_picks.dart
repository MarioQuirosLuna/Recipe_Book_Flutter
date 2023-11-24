import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_flutter/domain/entities/MealDetail.dart';

import '../../provider/recipe_book_provider.dart';

class TodayPicks extends StatelessWidget {
  const TodayPicks({
    super.key,
    required this.recipeProvider,
  });

  final RecipeBookProvider recipeProvider;

  @override
  Widget build(BuildContext context) {
    var todayPicks = recipeProvider.todayPicks;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var pick = todayPicks?.meals[index];
                return CardMeal(meal: pick);
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
      child: Text("Today's Picks",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          )
      ),
    );
  }
}

class CardMeal extends StatelessWidget {
  const CardMeal({
    super.key,
    required this.meal,
  });

  final MealDetail? meal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1.2,
          ),
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Row(
              children: [
                ImageCard(meal: meal),
                DetailsCard(meal: meal),
              ],
            ),
          )
        ),
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    super.key,
    required this.meal,
  });

  final MealDetail? meal;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meal?.strMeal ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(meal?.strCategory ?? "",
                      style: const TextStyle(
                        fontSize: 15,
                      )
                  ),
                  Text(meal?.strArea ?? "",
                      style: const TextStyle(
                        fontSize: 15,
                      )
                  ),
                ],
              )
            ],
          ),
        ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.meal,
  });

  final MealDetail? meal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1.2,
        ),
      ),
      child: CachedNetworkImage(
        width: 100,
        height: 100,
        imageUrl: meal?.strMealThumb ?? "",
        placeholder: (context, url) => const Center(heightFactor: 2, child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Center(heightFactor: 2, child: CircularProgressIndicator()),
      ),
    );
  }
}