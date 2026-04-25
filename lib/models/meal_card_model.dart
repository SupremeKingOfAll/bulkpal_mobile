import 'package:flutter/material.dart';

class MealCardModel {
  final String cardTitle;
  final double value;
  final double progressValue;
  final Color progressColour;

  MealCardModel({
    required this.cardTitle,
    required this.value,
    required this.progressValue,
    required this.progressColour,
  });
}
