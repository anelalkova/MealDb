class Meal {
  final String id;
  final String name;
  final String thumbnail;

  Meal({required this.id, required this.name, required this.thumbnail});

  factory Meal.fromJson(Map<String, dynamic> data) => Meal(
    id: data['idMeal'] ?? '',
    name: data['strMeal'].isNotEmpty
        ? data['strMeal'][0].toUpperCase() + data['strMeal'].substring(1)
        : '',
    thumbnail: data['strMealThumb'] ?? '',
  );
}