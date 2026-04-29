import 'package:bulkpal_mobile/models/logged_meal_model.dart';
import 'package:bulkpal_mobile/services/meal_log_firestore.dart';

class MealLogRepository {
  final MealLogFirestoreService _mealLogFirestoreService;

  MealLogRepository(this._mealLogFirestoreService);

  Future<void> AddMealLog(LoggedMealModel MealLog) async {
    await _mealLogFirestoreService.AddMealLog(MealLog);
  }

  Future<List<LoggedMealModel>> GetMealsForUserByDate({
    required String UserId,
    required DateTime SelectedDate,
  }) async {
    return await _mealLogFirestoreService.GetMealsForUserByDate(
      UserId: UserId,
      SelectedDate: SelectedDate,
    );
  }

  Stream<List<LoggedMealModel>> ListenToMealsForUserByDate({
    required String UserId,
    required DateTime SelectedDate,
  }) {
    return _mealLogFirestoreService.ListenToMealsForUserByDate(
      UserId: UserId,
      SelectedDate: SelectedDate,
    );
  }

  Future<void> UpdateMealLog(LoggedMealModel MealLog) async {
    await _mealLogFirestoreService.UpdateMealLog(MealLog);
  }

  Future<void> DeleteMealLog({
    required String UserId,
    required String MealLogId,
  }) async {
    await _mealLogFirestoreService.DeleteMealLog(
      UserId: UserId,
      MealLogId: MealLogId,
    );
  }
}
