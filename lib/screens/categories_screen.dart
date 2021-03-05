import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85 -
          MediaQuery.of(context).padding.top,
      child: GridView(
        padding: const EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        addRepaintBoundaries: true,
        children: DUMMY_CATEGORIES
            .map(
              (index) => CategoryItem(
                id: index.id,
                title: index.title,
                contBGColor: index.contBGColor,
              ),
            )
            .toList(),
      ),
    );
  }
}
