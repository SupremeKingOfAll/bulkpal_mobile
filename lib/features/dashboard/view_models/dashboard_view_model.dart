import 'package:flutter/material.dart';

class DashBoardViewModel with ChangeNotifier {
  int calorieTarget = 3000;
  int streakDays = 7;
  int adherenceScore = 82;

  double ProgressValue(int TotalCalories) {
    if (calorieTarget <= 0) {
      return 0.0;
    }

    return (TotalCalories / calorieTarget).clamp(0.0, 1.0);
  }

  int ProgressPercentage(int TotalCalories) {
    return (ProgressValue(TotalCalories) * 100).round();
  }

  int RemainingCalories(int TotalCalories) {
    final int Remaining = calorieTarget - TotalCalories;
    return Remaining < 0 ? 0 : Remaining;
  }

  int CalorieDifference(int TotalCalories) {
    return TotalCalories - calorieTarget;
  }
}
