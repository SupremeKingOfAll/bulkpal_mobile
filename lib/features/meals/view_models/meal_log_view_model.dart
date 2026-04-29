import 'dart:async';

import 'package:bulkpal_mobile/models/logged_meal_model.dart';
import 'package:bulkpal_mobile/repository/meal_log_repository.dart';
import 'package:bulkpal_mobile/services/meal_log_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WeeklyProgressData {
  const WeeklyProgressData({
    required this.DailyCalories,
    required this.WeeklyTotal,
    required this.WeeklyAverage,
    required this.WeeklyDifference,
    required this.AdherencePercentage,
  });

  final List<int> DailyCalories;
  final int WeeklyTotal;
  final int WeeklyAverage;
  final int WeeklyDifference;
  final int AdherencePercentage;
}

class MealLogViewModel extends ChangeNotifier {
  final MealLogRepository _mealLogRepository = MealLogRepository(
    MealLogFirestoreService(),
  );

  List<LoggedMealModel> _loggedMeals = [];
  List<LoggedMealModel> get LoggedMeals => _loggedMeals;

  DateTime _selectedDate = DateTime.now();
  DateTime get SelectedDate => _selectedDate;

  bool _isLoading = false;
  bool get IsLoading => _isLoading;

  String _errorMessage = '';
  String get ErrorMessage => _errorMessage;

  StreamSubscription<List<LoggedMealModel>>? _mealSubscription;

  int get TotalCalories {
    return _loggedMeals.fold(0, (Total, Meal) => Total + Meal.Calories);
  }

  int get TotalProtein {
    return _loggedMeals.fold(0, (Total, Meal) => Total + Meal.Protein);
  }

  int get TotalCarbs {
    return _loggedMeals.fold(0, (Total, Meal) => Total + Meal.Carbs);
  }

  int get TotalFats {
    return _loggedMeals.fold(0, (Total, Meal) => Total + Meal.Fats);
  }

  Future<void> LoadMealsForSelectedDate() async {
    final User? CurrentUser = FirebaseAuth.instance.currentUser;

    if (CurrentUser == null) {
      _errorMessage = 'No user is signed in.';
      _loggedMeals = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _loggedMeals = await _mealLogRepository.GetMealsForUserByDate(
        UserId: CurrentUser.uid,
        SelectedDate: _selectedDate,
      );

      _StartListeningToMeals(
        UserId: CurrentUser.uid,
        SelectedDate: _selectedDate,
      );
    } catch (Error) {
      _errorMessage = Error.toString();
      _loggedMeals = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void SetSelectedDate(DateTime NewDate) {
    _selectedDate = DateTime(NewDate.year, NewDate.month, NewDate.day);
    LoadMealsForSelectedDate();
  }

  Future<void> AddMealLog({
    required String Name,
    required String MealType,
    required int Calories,
    required int Protein,
    required int Carbs,
    required int Fats,
    double Servings = 1,
    DateTime? Date,
    String Source = 'manual',
    String? ExternalRecipeId,
    String? ThumbnailUrl,
  }) async {
    final User? CurrentUser = FirebaseAuth.instance.currentUser;

    if (CurrentUser == null) {
      _errorMessage = 'No user is signed in.';
      notifyListeners();
      return;
    }

    _errorMessage = '';

    final LoggedMealModel NewMealLog = LoggedMealModel(
      Id: DateTime.now().millisecondsSinceEpoch.toString(),
      UserId: CurrentUser.uid,
      Name: Name,
      MealType: MealType,
      Calories: Calories,
      Protein: Protein,
      Carbs: Carbs,
      Fats: Fats,
      Servings: Servings,
      Date: Date ?? _selectedDate,
      Source: Source,
      ExternalRecipeId: ExternalRecipeId,
      ThumbnailUrl: ThumbnailUrl,
    );

    try {
      await _mealLogRepository.AddMealLog(NewMealLog);
    } catch (Error) {
      _errorMessage = Error.toString();
      notifyListeners();
    }
  }

  Future<void> UpdateMealLog(LoggedMealModel MealLog) async {
    _errorMessage = '';
    notifyListeners();

    try {
      await _mealLogRepository.UpdateMealLog(MealLog);
    } catch (Error) {
      _errorMessage = Error.toString();
      notifyListeners();
    }
  }

  Future<void> DeleteMealLog(String MealLogId) async {
    final User? CurrentUser = FirebaseAuth.instance.currentUser;

    if (CurrentUser == null) {
      _errorMessage = 'No user is signed in.';
      notifyListeners();
      return;
    }

    _errorMessage = '';
    notifyListeners();

    try {
      await _mealLogRepository.DeleteMealLog(
        UserId: CurrentUser.uid,
        MealLogId: MealLogId,
      );
    } catch (Error) {
      _errorMessage = Error.toString();
      notifyListeners();
    }
  }

  DateTime _NormaliseDate(DateTime Value) {
    return DateTime(Value.year, Value.month, Value.day);
  }

  Future<WeeklyProgressData> GetWeeklyProgressData(int CalorieTarget) async {
    final User? CurrentUser = FirebaseAuth.instance.currentUser;

    if (CurrentUser == null) {
      return const WeeklyProgressData(
        DailyCalories: [0, 0, 0, 0, 0, 0, 0],
        WeeklyTotal: 0,
        WeeklyAverage: 0,
        WeeklyDifference: 0,
        AdherencePercentage: 0,
      );
    }

    final DateTime Today = _NormaliseDate(DateTime.now());

    final List<int> DailyCalories = [];
    int WeeklyTotal = 0;
    int DaysMeetingTarget = 0;

    for (int Index = 6; Index >= 0; Index--) {
      final DateTime Day = Today.subtract(Duration(days: Index));

      final List<LoggedMealModel> Meals =
          await _mealLogRepository.GetMealsForUserByDate(
            UserId: CurrentUser.uid,
            SelectedDate: Day,
          );

      final int DayCalories = Meals.fold(
        0,
        (Total, Meal) => Total + Meal.Calories,
      );

      DailyCalories.add(DayCalories);
      WeeklyTotal += DayCalories;

      if (DayCalories >= CalorieTarget) {
        DaysMeetingTarget++;
      }
    }

    final int WeeklyAverage = (WeeklyTotal / 7).round();
    final int WeeklyDifference = WeeklyTotal - (CalorieTarget * 7);
    final int AdherencePercentage = ((DaysMeetingTarget / 7) * 100).round();

    return WeeklyProgressData(
      DailyCalories: DailyCalories,
      WeeklyTotal: WeeklyTotal,
      WeeklyAverage: WeeklyAverage,
      WeeklyDifference: WeeklyDifference,
      AdherencePercentage: AdherencePercentage,
    );
  }

  void _StartListeningToMeals({
    required String UserId,
    required DateTime SelectedDate,
  }) {
    _mealSubscription?.cancel();

    _mealSubscription =
        _mealLogRepository.ListenToMealsForUserByDate(
          UserId: UserId,
          SelectedDate: SelectedDate,
        ).listen(
          (Meals) {
            _loggedMeals = Meals;
            notifyListeners();
          },
          onError: (Error) {
            _errorMessage = Error.toString();
            notifyListeners();
          },
        );
  }

  @override
  void dispose() {
    _mealSubscription?.cancel();
    super.dispose();
  }
}
