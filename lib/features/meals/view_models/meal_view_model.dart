import 'package:bulkpal_mobile/models/meal_model.dart';
import 'package:bulkpal_mobile/repository/meal_repository.dart';
import 'package:bulkpal_mobile/services/meal_firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MealModelView extends ChangeNotifier {
  final MealRepository _mealRepository = MealRepository(MealFirestoreService());

  List<MealModel> _meals = [];
  List<MealModel> get Meals => _meals;

  bool _isLoading = false;
  bool get IsLoading => _isLoading;

  String _errorMessage = '';
  String get ErrorMessage => _errorMessage;

  Future<void> LoadMeals() async {
    final User? CurrentUser = FirebaseAuth.instance.currentUser;

    if (CurrentUser == null) {
      _errorMessage = 'No user is signed in.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _meals = await _mealRepository.GetMealsForUser(CurrentUser.uid);
    } catch (Error) {
      _errorMessage = Error.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> AddMeal({
    required String Name,
    required int Calories,
    required int Protein,
    required int Carbs,
    required int Fats,
    String Source = 'manual',
  }) async {
    final User? CurrentUser = FirebaseAuth.instance.currentUser;

    if (CurrentUser == null) {
      _errorMessage = 'No user is signed in.';
      notifyListeners();
      return;
    }

    final MealModel NewMeal = MealModel(
      Id: DateTime.now().millisecondsSinceEpoch.toString(),
      Name: Name,
      Calories: Calories,
      Protein: Protein,
      Carbs: Carbs,
      Fats: Fats,
      Date: DateTime.now(),
      UserId: CurrentUser.uid,
      Source: Source,
    );

    try {
      await _mealRepository.AddMeal(NewMeal);
      _meals.insert(0, NewMeal);
      notifyListeners();
    } catch (Error) {
      _errorMessage = Error.toString();
      notifyListeners();
    }
  }

  Future<void> RemoveMeal(String MealId) async {
    final User? CurrentUser = FirebaseAuth.instance.currentUser;

    if (CurrentUser == null) {
      _errorMessage = 'No user is signed in.';
      notifyListeners();
      return;
    }

    try {
      await _mealRepository.RemoveMeal(UserId: CurrentUser.uid, MealId: MealId);

      _meals.removeWhere((Meal) => Meal.Id == MealId);
      notifyListeners();
    } catch (Error) {
      _errorMessage = Error.toString();
      notifyListeners();
    }
  }
}
