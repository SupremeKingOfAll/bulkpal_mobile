import 'package:bulkpal_mobile/models/meal_model.dart';

class MealRepository {} //separates data logic from UI.

final List<MealModel> _meals = [];

void addMeal(MealModel meal) {
  _meals.add(meal);
}

void removeMeal(MealModel meal) {
  _meals.remove(meal);
}

List<MealModel> _getMeals() {
  return _meals;
}
