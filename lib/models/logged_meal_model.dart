import 'package:cloud_firestore/cloud_firestore.dart';

class LoggedMealModel {
  final String Id;
  final String UserId;
  final String Name;
  final String MealType;
  final int Calories;
  final int Protein;
  final int Carbs;
  final int Fats;
  final double Servings;
  final DateTime Date;
  final String Source;
  final String? ExternalRecipeId;
  final String? ThumbnailUrl;

  LoggedMealModel({
    required this.Id,
    required this.UserId,
    required this.Name,
    required this.MealType,
    required this.Calories,
    required this.Protein,
    required this.Carbs,
    required this.Fats,
    required this.Servings,
    required this.Date,
    required this.Source,
    this.ExternalRecipeId,
    this.ThumbnailUrl,
  });

  Map<String, dynamic> ToMap() {
    return {
      'id': Id,
      'userId': UserId,
      'name': Name,
      'mealType': MealType,
      'calories': Calories,
      'protein': Protein,
      'carbs': Carbs,
      'fats': Fats,
      'servings': Servings,
      'date': Timestamp.fromDate(Date),
      'source': Source,
      'externalRecipeId': ExternalRecipeId,
      'thumbnailUrl': ThumbnailUrl,
    };
  }

  factory LoggedMealModel.FromMap(Map<String, dynamic> MapData) {
    final dynamic RawDate = MapData['date'];

    DateTime ParsedDate = DateTime.now();

    if (RawDate is Timestamp) {
      ParsedDate = RawDate.toDate();
    } else if (RawDate is String && RawDate.isNotEmpty) {
      ParsedDate = DateTime.tryParse(RawDate) ?? DateTime.now();
    }

    return LoggedMealModel(
      Id: MapData['id'] ?? '',
      UserId: MapData['userId'] ?? '',
      Name: MapData['name'] ?? '',
      MealType: MapData['mealType'] ?? 'Other',
      Calories: (MapData['calories'] ?? 0) as int,
      Protein: (MapData['protein'] ?? 0) as int,
      Carbs: (MapData['carbs'] ?? 0) as int,
      Fats: (MapData['fats'] ?? 0) as int,
      Servings: (MapData['servings'] ?? 1).toDouble(),
      Date: ParsedDate,
      Source: MapData['source'] ?? 'manual',
      ExternalRecipeId: MapData['externalRecipeId'],
      ThumbnailUrl: MapData['thumbnailUrl'],
    );
  }

  LoggedMealModel CopyWith({
    String? Id,
    String? UserId,
    String? Name,
    String? MealType,
    int? Calories,
    int? Protein,
    int? Carbs,
    int? Fats,
    double? Servings,
    DateTime? Date,
    String? Source,
    String? ExternalRecipeId,
    String? ThumbnailUrl,
  }) {
    return LoggedMealModel(
      Id: Id ?? this.Id,
      UserId: UserId ?? this.UserId,
      Name: Name ?? this.Name,
      MealType: MealType ?? this.MealType,
      Calories: Calories ?? this.Calories,
      Protein: Protein ?? this.Protein,
      Carbs: Carbs ?? this.Carbs,
      Fats: Fats ?? this.Fats,
      Servings: Servings ?? this.Servings,
      Date: Date ?? this.Date,
      Source: Source ?? this.Source,
      ExternalRecipeId: ExternalRecipeId ?? this.ExternalRecipeId,
      ThumbnailUrl: ThumbnailUrl ?? this.ThumbnailUrl,
    );
  }
}
