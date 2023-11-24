import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_flutter/presentation/provider/recipe_book_provider.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/home/categories_list.dart';
import '../../widgets/home/search_recipe.dart';
import '../../widgets/home/today_picks.dart';
import '../../widgets/shared/app_bar_settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    super.initState();
    _loadSettings();
    _loadCategories();
    _loadTodayPicks();
  }
  _loadSettings() async {
    final settingsProvider = context.read<ThemeProvider>();
    await settingsProvider.loadSettings();
  }
  _loadCategories() async {
    final recipeBookProvider = context.read<RecipeBookProvider>();
    await recipeBookProvider.loadCategories();
  }
  _loadTodayPicks() async {
    final recipeBookProvider = context.read<RecipeBookProvider>();
    await recipeBookProvider.loadTodayPicks();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.watch<RecipeBookProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBarSettings(title: "Home"),
        body: SafeArea(
          child: Column(
            children: [
              const SearchRecipe(),
              const CategoriesList(),
              TodayPicks(recipeProvider: recipeProvider),
            ],
          ),
        ),
      ),
    );
  }
}



