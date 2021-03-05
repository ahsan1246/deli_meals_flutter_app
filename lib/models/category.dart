import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color contBGColor;

  const Category({
    @required this.id,
    @required this.title,
    this.contBGColor = Colors.brown,
  });
}
