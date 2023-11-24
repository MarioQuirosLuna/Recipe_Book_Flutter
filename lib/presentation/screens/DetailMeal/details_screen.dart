import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/recipe_book_provider.dart';
import '../../widgets/shared/app_bar_settings.dart';

class Details extends StatefulWidget {
  Details({
    super.key,
    required this.idMeal
  });

  String idMeal;

  @override
  DetailsState createState() => DetailsState();
}

class DetailsState extends State<Details> {
  late Future<void> _loadMealDetailsFuture;

  @override
  void initState() {
    super.initState();
    _loadMealDetailsFuture = _loadMealDetails();
  }

  Future<void> _loadMealDetails() async {
    final recipeProvider = context.read<RecipeBookProvider>();
    await recipeProvider.loadMealDetails(widget.idMeal);
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.watch<RecipeBookProvider>();
    return Scaffold(
      appBar: AppBarSettings(title: "Details",),
      body: Center(
        child: FutureBuilder<void>(
            future: _loadMealDetailsFuture,
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }else{
                return Expanded(
                    child: ListView(
                      children: [
                        Stack(
                          children: [
                            _Image(recipeProvider: recipeProvider),
                            _Information(recipeProvider: recipeProvider),
                          ],
                        ),
                      ],
                    )
                );
              }
            }
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.recipeProvider,
  });

  final RecipeBookProvider recipeProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 350,
      child: Image.network(
          recipeProvider.mealDetails!.meals[0].strMealThumb,
          fit: BoxFit.cover
      ),
    );
  }
}

class _Information extends StatelessWidget {
  const _Information({
    required this.recipeProvider,
  });

  final RecipeBookProvider recipeProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 300),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipeProvider.mealDetails!.meals[0].strMeal,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(text: "Details",),
                      Tab(text: "Ingredients",),
                      Tab(text: "Instructions",),
                      Tab(text: "Video",),
                    ],
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      children: [
                        Text("Details"),
                        Text("Ingredients"),
                        Text("Instructions"),
                        Text("Video"),
                      ],
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
