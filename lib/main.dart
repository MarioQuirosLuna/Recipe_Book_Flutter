import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_flutter/config/theme/app_theme.dart';
import 'package:recipe_book_flutter/presentation/provider/recipe_book_provider.dart';
import 'package:recipe_book_flutter/presentation/screens/home/home_screen.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => ThemeProvider()..loadSettings()
            ),
            ChangeNotifierProvider(
                create: (_) => RecipeBookProvider()
            )
          ],
          child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider  = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: "Recipe Book",
      debugShowCheckedModeBanner: false,
      theme: themeProvider .getTheme(),
      home: const HomeScreen(),
    );
  }
}
