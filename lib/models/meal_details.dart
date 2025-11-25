class MealDetails {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final String youtube;
  final Map<String, String> ingredients;
  final List<String> steps;

  MealDetails({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.youtube,
    required this.ingredients,
    required this.steps,
  });

  factory MealDetails.fromJson(Map<String, dynamic> data) {
    final Map<String, String> ing = {};
    for (int i = 1; i <= 20; i++) {
      final keyIng = 'strIngredient$i';
      final keyMea = 'strMeasure$i';
      final ingVal = (data[keyIng] ?? '').toString().trim();
      final meaVal = (data[keyMea] ?? '').toString().trim();
      if (ingVal.isNotEmpty) {
        ing[ingVal] = meaVal;
      }
    }

    final rawInstructions = (data['strInstructions'] ?? '').toString();

    return MealDetails(
      id: data['idMeal'] ?? '',
      name: data['strMeal'].isNotEmpty
          ? data['strMeal'][0].toUpperCase() + data['strMeal'].substring(1)
          : '',
      category: data['strCategory'] ?? '',
      area: data['strArea'] ?? '',
      instructions: rawInstructions,
      thumbnail: data['strMealThumb'] ?? '',
      youtube: data['strYoutube'] ?? '',
      ingredients: ing,
      steps: _parseSteps(rawInstructions),
    );
  }

  static List<String> _parseSteps(String raw) {
    raw = raw.replaceAll('\r\n', '\n');
    List<String> steps = [];

    final stepRegex = RegExp(r'step\s*\d+[:\s]*', caseSensitive: false);

    if (stepRegex.hasMatch(raw)) {
      steps = raw.split(stepRegex)
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    } else if (raw.contains('\n\n')) {
      steps = raw.split('\n\n')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    } else {
      steps = raw.split('\n')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    }
    return steps;
  }
}
