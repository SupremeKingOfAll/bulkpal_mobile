import 'package:flutter/material.dart';

class DashBoardViewModel with ChangeNotifier {
  // dummy data
  int caloriesConsumed = 2450;
  int calorieTarget = 3000;
  int streakDays = 7;
  int adherenceScore = 82;
  int surplusCalories = 320;

  int ProgressPercentage() {
    return ((caloriesConsumed / calorieTarget) * 100).round();
  }

  int RemainingCalories() {
    return calorieTarget - caloriesConsumed;
  }

  double ProgressValue() {
    return caloriesConsumed / calorieTarget;
  }
}
