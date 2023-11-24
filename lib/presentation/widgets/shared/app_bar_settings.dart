import 'package:flutter/material.dart';

import '../../screens/settings/settings.dart';

class AppBarSettings extends StatelessWidget implements PreferredSizeWidget {
  AppBarSettings({
    super.key,
    required this.title,
  });

  String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
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