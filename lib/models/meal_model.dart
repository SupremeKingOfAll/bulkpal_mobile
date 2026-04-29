class MealModel {
  final String Id;
  final String Name;
  final int Calories;
  final int Protein;
  final int Carbs;
  final int Fats;
  final DateTime Date;
  final String UserId;
  final String Source;

  MealModel({
    required this.Id,
    required this.Name,
    required this.Calories,
    required this.Protein,
    required this.Carbs,
    required this.Fats,
    required this.Date,
    required this.UserId,
    required this.Source,
  });

  Map<String, dynamic> ToMap() {
    return {
      'id': Id,
      'name': Name,
      'calories': Calories,
      'protein': Protein,
      'carbs': Carbs,
      'fats': Fats,
      'date': Date.toIso8601String(),
      'userId': UserId,
      'source': Source,
    };
  }

  factory MealModel.FromMap(Map<String, dynamic> MapData) {
    return MealModel(
      Id: MapData['id'] ?? '',
      Name: MapData['name'] ?? '',
      Calories: MapData['calories'] ?? 0,
      Protein: MapData['protein'] ?? 0,
      Carbs: MapData['carbs'] ?? 0,
      Fats: MapData['fats'] ?? 0,
      Date: DateTime.parse(MapData['date']),
      UserId: MapData['userId'] ?? '',
      Source: MapData['source'] ?? 'manual',
    );
  }
}
