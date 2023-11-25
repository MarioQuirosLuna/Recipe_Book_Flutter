import 'package:flutter/material.dart';

class TabBarForMealDetails extends StatelessWidget {
  const TabBarForMealDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Theme.of(context).colorScheme.primary,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Theme.of(context).colorScheme.primary,
      tabs: const [
        Tab(text: "Details",),
        Tab(text: "Ingredients",),
        Tab(text: "Instructions",),
        Tab(text: "Video",),
      ],
    );
  }
}