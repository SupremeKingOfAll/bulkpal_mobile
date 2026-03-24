import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/models/meal_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MealModelView with ChangeNotifier {
  final List<MealModel> mList = [
    MealModel(
      cardTitle: "CALORIES",
      value: 2450,
      progressValue: 0.90,
      progressColour: AppColours.secondaryAccent,
    ),
    MealModel(
      cardTitle: "MEALS",
      value: 4,
      progressValue: 0.4,
      progressColour: AppColours.navActive,
    ),
    MealModel(
      cardTitle: "PROTEIN",
      value: 180,
      progressValue: 0.75,
      progressColour: AppColours.secondaryAccent,
    ),
  ];

  final List<String> Categories = ["All", "Breakfast", "Lunch", "Dinner"];
}
