class MealApiModel {
  final String Id;
  final String Name;
  final String Category;
  final String Area;
  final String Instructions;
  final String Thumbnail;
  final String YoutubeUrl;
  final List<String> Ingredients;
  final List<String> Measures;

  MealApiModel({
    required this.Id,
    required this.Name,
    required this.Category,
    required this.Area,
    required this.Instructions,
    required this.Thumbnail,
    required this.YoutubeUrl,
    required this.Ingredients,
    required this.Measures,
  });

  factory MealApiModel.FromMap(Map<String, dynamic> MapData) {
    List<String> Ingredients = [];
    List<String> Measures = [];

    for (int i = 1; i <= 20; i++) {
      final String Ingredient = (MapData['strIngredient$i'] ?? '')
          .toString()
          .trim();
      final String Measure = (MapData['strMeasure$i'] ?? '').toString().trim();

      if (Ingredient.isNotEmpty) {
        Ingredients.add(Ingredient);
        Measures.add(Measure);
      }
    }

    return MealApiModel(
      Id: MapData['idMeal'] ?? '',
      Name: MapData['strMeal'] ?? '',
      Category: MapData['strCategory'] ?? '',
      Area: MapData['strArea'] ?? '',
      Instructions: MapData['strInstructions'] ?? '',
      Thumbnail: MapData['strMealThumb'] ?? '',
      YoutubeUrl: MapData['strYoutube'] ?? '',
      Ingredients: Ingredients,
      Measures: Measures,
    );
  }
}
