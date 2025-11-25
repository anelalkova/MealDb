import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/api_service.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/meal_card.dart';
import 'meal_details.dart';

class MealsScreen extends StatefulWidget {
  final String category;

  const MealsScreen({super.key, required this.category});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final ApiService api = ApiService();
  List<Meal> meals = [];
  List<Meal> filteredMeals = [];
  bool loading = true;
  String searchQuery = "";
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: searchMeals,
                  decoration: InputDecoration(
                    hintText: "Search meals...",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                          searchQuery = '';
                          filteredMeals = meals;
                        });
                      },
                    )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.shuffle),
              onPressed: () async {
                try {
                  final meal = await api.getRandomMeal();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MealDetailScreen(mealId: meal.id),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error fetching random meal: $e')),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: filteredMeals.isEmpty
                ? const Center(
              child: Text(
                "No meals found.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredMeals.length,
              itemBuilder: (context, index) {
                return MealCard(meal: filteredMeals[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Center(
              child: SizedBox(
                width: 185,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Anastasija Lalkova 223023",
                    hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    isDense: true,
                  ),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void loadMeals() async {
    final data = await api.getMealsByCategory(widget.category);
    setState(() {
      meals = data;
      filteredMeals = data;
      loading = false;
    });
  }

  void searchMeals(String query) {
    setState(() => searchQuery = query);
    if (query.isEmpty) {
      filteredMeals = meals;
    } else {
      filteredMeals = meals
          .where((meal) => meal.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
