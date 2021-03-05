import 'package:flutter/material.dart';
// import './screens/top_tabs_screen.dart';
import './screens/bottom_tabs_screen.dart';
import './models/meal.dart';
import './dummy_data.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/filters_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Filter regarding data
  Map<String, bool> _filters = {
    "gluten": false,
    "vegetarian": false,
    "vegan": false,
    "lactose": false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    print(filterData);
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((filteredMealVal) {
        if (_filters['gluten'] && !filteredMealVal.isGlutenFree) return false;
        if (_filters['vegetarian'] && !filteredMealVal.isVegetarian)
          return false;
        if (_filters['vegan'] && !filteredMealVal.isVegan) return false;
        if (_filters['lactose'] && !filteredMealVal.isLactoseFree) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((markFavMeal) => markFavMeal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((favMeal) => favMeal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((favMeal) => favMeal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deli Meals',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          accentColor: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              )),
      // home: MyHomePage(),
      // alternate way (initialRoute ke b zroorat ni the yahan pr
      // yeh just btany k leay k kis screen sy app start krni hy.
      // "/" means home page)
      initialRoute: '/',
      routes: {
        // '/': (ctx) => TopTabsScreen(),
        '/': (ctx) => BottomTabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
      },
    );
  }
}
