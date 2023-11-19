import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_flutter/presentation/provider/recipe_book_provider.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/home/CategoriesList.dart';
import '../../widgets/home/search_recipe.dart';
import '../settings/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    super.initState();
    //TODO: Load the recipes from the API
    _loadSettings();
    _loadCategories();
    print("HomeScreen initState");
  }
  _loadSettings() async {
    final settingsProvider = context.read<ThemeProvider>();
    await settingsProvider.loadSettings();
  }
  _loadCategories() async {
    final recipeBookProvider = context.read<RecipeBookProvider>();
    await recipeBookProvider.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.watch<RecipeBookProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: SafeArea(
          child: Column(
            children: [
              const SearchRecipe(),
              CategoriesList(recipeProvider: recipeProvider),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen())
              );
            },
          )],
      );
  }
}

