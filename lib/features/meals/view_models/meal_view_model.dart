import 'package:bulkpal_mobile/models/meal_model_api.dart';
import 'package:bulkpal_mobile/repository/meal_repository.dart';
import 'package:bulkpal_mobile/services/meal_api_service.dart';
import 'package:flutter/material.dart';

class MealViewModel extends ChangeNotifier {
  final MealRepository _mealRepository = MealRepository(MealApiService());

  List<MealApiModel> _apiMeals = [];
  List<MealApiModel> get ApiMeals => _apiMeals;

  List<String> _categories = ['All'];
  List<String> get Categories => _categories;

  bool _isLoading = false;
  bool get IsLoading => _isLoading;

  String _errorMessage = '';
  String get ErrorMessage => _errorMessage;

  Future<void> LoadMeals() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final List<String> LoadedCategories =
          await _mealRepository.GetCategories();
      _categories = ['All', ...LoadedCategories];

      _apiMeals = await _mealRepository.SearchMeals('chicken');
    } catch (Error) {
      _errorMessage = Error.toString();
      _apiMeals = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> SearchMeals(String Query) async {
    final String CleanQuery = Query.trim();

    if (CleanQuery.isEmpty) {
      await LoadMeals();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _apiMeals = await _mealRepository.SearchMeals(CleanQuery);
    } catch (Error) {
      _errorMessage = Error.toString();
      _apiMeals = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> LoadMealsByCategory(String Category) async {
    if (Category == 'All') {
      await LoadMeals();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _apiMeals = await _mealRepository.GetMealsByCategory(Category);
    } catch (Error) {
      _errorMessage = Error.toString();
      _apiMeals = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> RemoveMeal(String MealId) async {
    _apiMeals.removeWhere((Meal) => Meal.Id == MealId);
    notifyListeners();
  }
}
