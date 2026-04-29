import 'package:bulkpal_mobile/models/meal_model_api.dart';
import 'package:bulkpal_mobile/services/meal_api_service.dart';

class MealRepository {
  final MealApiService _mealApiService;

  MealRepository(this._mealApiService);

  Future<List<MealApiModel>> SearchMeals(String Query) async {
    return await _mealApiService.SearchMeals(Query);
  }

  Future<List<String>> GetCategories() async {
    return await _mealApiService.GetCategories();
  }

  Future<List<MealApiModel>> GetMealsByCategory(String Category) async {
    return await _mealApiService.GetMealsByCategory(Category);
  }

  Future<MealApiModel?> GetMealById(String MealId) async {
    return await _mealApiService.GetMealById(MealId);
  }
}
