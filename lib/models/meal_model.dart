import 'package:flutter/material.dart';

class MealModel {
  final String cardTitle;
  final double value;
  final double progressValue;
  final Color progressColour;

  MealModel({
    required this.cardTitle,
    required this.value,
    required this.progressValue,
    required this.progressColour,
  });
}
