import 'package:bulkpal_mobile/models/meal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealFirestoreService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> AddMeal(MealModel Meal) async {
    await _fireStore
        .collection('users')
        .doc(Meal.UserId)
        .collection('meals')
        .doc(Meal.Id)
        .set(Meal.ToMap());
  }

  Future<List<MealModel>> GetMealsForUser(String UserId) async {
    final QuerySnapshot Snapshot = await _fireStore
        .collection('users')
        .doc(UserId)
        .collection('meals')
        .orderBy('date', descending: true)
        .get();

    return Snapshot.docs.map((Document) {
      return MealModel.FromMap(Document.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> DeleteMeal({
    required String UserId,
    required String MealId,
  }) async {
    await _fireStore
        .collection('users')
        .doc(UserId)
        .collection('meals')
        .doc(MealId)
        .delete();
  }

  Future<void> UpdateMeal(MealModel Meal) async {
    await _fireStore
        .collection('users')
        .doc(Meal.UserId)
        .collection('meals')
        .doc(Meal.Id)
        .update(Meal.ToMap());
  }
}
