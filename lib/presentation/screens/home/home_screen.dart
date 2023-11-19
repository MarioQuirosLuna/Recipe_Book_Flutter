import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/app_theme.dart';
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
  }
  _loadSettings() async {
    final settingsProvider = context.read<ThemeProvider>();
    await settingsProvider.loadSettings();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Recipe Book'),
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
        ),
        body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Welcome to Recipe Book',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}