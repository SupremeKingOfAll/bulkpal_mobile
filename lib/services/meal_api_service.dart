import 'dart:convert';
import 'package:bulkpal_mobile/models/meal_model_api.dart';
import 'package:http/http.dart' as http;

class MealApiService {
  static const String BaseHost = 'www.themealdb.com';
  static const String BasePath = '/api/json/v1/1';

  Future<List<MealApiModel>> SearchMeals(String Query) async {
    final Uri Url = Uri.https(BaseHost, '$BasePath/search.php', {'s': Query});

    final http.Response Response = await http.get(Url);

    if (Response.statusCode != 200) {
      throw Exception('Failed to search meals.');
    }

    final Map<String, dynamic> Data = jsonDecode(Response.body);
    final List<dynamic>? Meals = Data['meals'];

    if (Meals == null) {
      return [];
    }

    return Meals.map(
      (Meal) => MealApiModel.FromMap(Meal as Map<String, dynamic>),
    ).toList();
  }

  Future<List<String>> GetCategories() async {
    final Uri Url = Uri.https(BaseHost, '$BasePath/list.php', {'c': 'list'});

    final http.Response Response = await http.get(Url);

    if (Response.statusCode != 200) {
      throw Exception('Failed to load categories.');
    }

    final Map<String, dynamic> Data = jsonDecode(Response.body);
    final List<dynamic>? Categories = Data['meals'];

    if (Categories == null) {
      return [];
    }

    return Categories.map(
      (Category) => Category['strCategory'].toString(),
    ).toList();
  }

  Future<List<MealApiModel>> GetMealsByCategory(String Category) async {
    final Uri Url = Uri.https(BaseHost, '$BasePath/filter.php', {
      'c': Category,
    });

    final http.Response Response = await http.get(Url);

    if (Response.statusCode != 200) {
      throw Exception('Failed to load meals by category.');
    }

    final Map<String, dynamic> Data = jsonDecode(Response.body);
    final List<dynamic>? Meals = Data['meals'];

    if (Meals == null) {
      return [];
    }

    return Meals.map((Meal) {
      final Map<String, dynamic> MealMap = Meal as Map<String, dynamic>;

      return MealApiModel(
        Id: MealMap['idMeal'] ?? '',
        Name: MealMap['strMeal'] ?? '',
        Category: Category,
        Area: '',
        Instructions: '',
        Thumbnail: MealMap['strMealThumb'] ?? '',
        YoutubeUrl: '',
        Ingredients: [],
        Measures: [],
      );
    }).toList();
  }

  Future<MealApiModel?> GetMealById(String MealId) async {
    final Uri Url = Uri.https(BaseHost, '$BasePath/lookup.php', {'i': MealId});

    final http.Response Response = await http.get(Url);

    if (Response.statusCode != 200) {
      throw Exception('Failed to load meal details.');
    }

    final Map<String, dynamic> Data = jsonDecode(Response.body);
    final List<dynamic>? Meals = Data['meals'];

    if (Meals == null || Meals.isEmpty) {
      return null;
    }

    return MealApiModel.FromMap(Meals.first as Map<String, dynamic>);
  }
}
