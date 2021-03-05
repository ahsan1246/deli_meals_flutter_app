import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeItem;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageURL,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    this.removeItem,
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Difficult:
        return 'Difficult';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
        break;
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      default:
        return 'Unknown';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3.0,
        margin: EdgeInsets.all(10.0),
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: Image.network(
                  imageURL,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 0,
                child: Container(
                  color: Colors.white60,
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15,
                  ),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline5,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('$duration min')
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.work,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('$complexityText')
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('$affordabilityText')
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void selectMeal(BuildContext ctx) async {
    Navigator.of(ctx)
        .pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    )
        .then((result) {
      print(result);
      if (result != null) removeItem(result);
    });
    // var delAction = await Navigator.of(ctx).pushNamed(
    //   MealDetailScreen.routeName,
    //   arguments: id,
    // );
    // print(delAction);
  }
}
