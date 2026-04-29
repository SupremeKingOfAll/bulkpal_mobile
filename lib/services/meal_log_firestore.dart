import 'package:bulkpal_mobile/models/logged_meal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealLogFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _mealLogsRef(String UserId) {
    return _firestore.collection('users').doc(UserId).collection('meal_logs');
  }

  Future<void> AddMealLog(LoggedMealModel MealLog) async {
    await _mealLogsRef(MealLog.UserId).doc(MealLog.Id).set(MealLog.ToMap());
  }

  Future<List<LoggedMealModel>> GetMealsForUserByDate({
    required String UserId,
    required DateTime SelectedDate,
  }) async {
    final DateTime StartOfDay = DateTime(
      SelectedDate.year,
      SelectedDate.month,
      SelectedDate.day,
    );

    final DateTime EndOfDay = StartOfDay.add(const Duration(days: 1));

    final QuerySnapshot<Map<String, dynamic>> Snapshot =
        await _mealLogsRef(UserId)
            .where(
              'date',
              isGreaterThanOrEqualTo: Timestamp.fromDate(StartOfDay),
            )
            .where('date', isLessThan: Timestamp.fromDate(EndOfDay))
            .orderBy('date', descending: true)
            .get();

    return Snapshot.docs
        .map((Document) => LoggedMealModel.FromMap(Document.data()))
        .toList();
  }

  Stream<List<LoggedMealModel>> ListenToMealsForUserByDate({
    required String UserId,
    required DateTime SelectedDate,
  }) {
    final DateTime StartOfDay = DateTime(
      SelectedDate.year,
      SelectedDate.month,
      SelectedDate.day,
    );

    final DateTime EndOfDay = StartOfDay.add(const Duration(days: 1));

    return _mealLogsRef(UserId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(StartOfDay))
        .where('date', isLessThan: Timestamp.fromDate(EndOfDay))
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (Snapshot) => Snapshot.docs
              .map((Document) => LoggedMealModel.FromMap(Document.data()))
              .toList(),
        );
  }

  Future<void> UpdateMealLog(LoggedMealModel MealLog) async {
    await _mealLogsRef(MealLog.UserId).doc(MealLog.Id).update(MealLog.ToMap());
  }

  Future<void> DeleteMealLog({
    required String UserId,
    required String MealLogId,
  }) async {
    await _mealLogsRef(UserId).doc(MealLogId).delete();
  }
}
