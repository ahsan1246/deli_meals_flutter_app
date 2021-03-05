import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meal-screen';

  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryId;
  String categoryTitle;
  Color categoryColor;
  List<Meal> displayedMeals;
  var _loadInItData = false;

  //Methods

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadInItData) {
      // with pushNamed
      final catMealArgu =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      final categoryId = catMealArgu['catId'];
      categoryTitle = catMealArgu['catTitle'];
      categoryColor = catMealArgu['catColor'];
      //to filter meal from list based on categoryId
      displayedMeals = widget.availableMeals.where((mealElement) {
        return mealElement.categories.contains(categoryId);
      }).toList();
      _loadInItData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMealFun(String mealId) {
    setState(() {
      displayedMeals.removeWhere((mealElement) => mealElement.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: categoryColor,
        title: Text(
          categoryTitle,
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: displayedMeals.length,
        itemBuilder: (context, index) {
          return MealItem(
            id: displayedMeals.elementAt(index).id,
            title: displayedMeals.elementAt(index).title,
            imageURL: displayedMeals.elementAt(index).imageUrl,
            duration: displayedMeals.elementAt(index).duration,
            complexity: displayedMeals.elementAt(index).complexity,
            affordability: displayedMeals.elementAt(index).affordability,
            removeItem: _removeMealFun,
          );
        },
      ),
    );
  }
}
