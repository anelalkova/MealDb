import 'package:flutter/material.dart';
import 'package:second_laboratory_exercise/services/favourites_service.dart';
import '../widgets/meal_card.dart';
import '../models/meal.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favourite Meals")),
      body: FutureBuilder<List<Meal>>(
        future: FavouritesService.getFavourites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No favorite meals yet."));
          }

          final favourites = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: favourites.length,
            itemBuilder: (_, i) => MealCard(meal: favourites[i]),
          );
        },
      ),
    );
  }
}
