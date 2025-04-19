
import 'package:flutter/material.dart';

class MainCardModel {
  final String imagePath;
  final String title;
  final String quote;
  final Widget Function() page;

  MainCardModel({
    required this.imagePath,
    required this.title,
    required this.quote,
    required this.page,
  });
}



class ItemCardModel{
  final String imagePath;
  final String title;
  final String details;

  ItemCardModel({
    required this.imagePath, 
    required this.title,
    required this.details});
}


