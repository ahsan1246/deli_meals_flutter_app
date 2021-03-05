import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text("You have no Favorites Meal yet."),
      );
    } else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (context, index) {
          return MealItem(
            id: favoriteMeals.elementAt(index).id,
            title: favoriteMeals.elementAt(index).title,
            imageURL: favoriteMeals.elementAt(index).imageUrl,
            duration: favoriteMeals.elementAt(index).duration,
            complexity: favoriteMeals.elementAt(index).complexity,
            affordability: favoriteMeals.elementAt(index).affordability,
          );
        },
      );
    }
  }
}
