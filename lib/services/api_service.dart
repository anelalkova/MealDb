import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_details.dart';

const String apiBase = 'https://www.themealdb.com/api/json/v1/1';

class ApiService {
  Future<List<Category>> loadCategories() async {
    final res = await http.get(Uri.parse('$apiBase/categories.php'));
    final data = json.decode(res.body);
    return (data['categories'] as List).map((e) => Category.fromJson(e)).toList();
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    final res = await http.get(Uri.parse('$apiBase/filter.php?c=$category'));
    final data = json.decode(res.body);
    return (data['meals'] as List).map((e) => Meal.fromJson(e)).toList();
  }

  Future<MealDetails> getMealDetail(String id) async {
    final res = await http.get(Uri.parse('$apiBase/lookup.php?i=$id'));
    final data = json.decode(res.body);
    return MealDetails.fromJson(data['meals'][0]);
  }

  Future<MealDetails> getRandomMeal() async {
    final res = await http.get(Uri.parse('$apiBase/random.php'));
    final data = json.decode(res.body);
    return MealDetails.fromJson(data['meals'][0]);
  }
}
