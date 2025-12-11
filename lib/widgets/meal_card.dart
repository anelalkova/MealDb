import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/meal_details.dart';
import '../services/favourites_service.dart';

class MealCard extends StatefulWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    _loadFavourite();
  }

  void _loadFavourite() async {
    final fav = await FavouritesService.isFavourite(widget.meal);
    setState(() {
      isFav = fav;
    });
  }

  void _toggleFavourite() async {
    if (isFav) {
      await FavouritesService.removeFavourite(widget.meal);
    } else {
      await FavouritesService.addFavourite(widget.meal);
    }

    setState(() {
      isFav = !isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetailScreen(mealId: widget.meal.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300.withOpacity(0.4),
              blurRadius: 5,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Opacity(
                opacity: 0.5,
                child: Image.network(
                  widget.meal.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
              Container(color: Colors.black.withOpacity(0.3)),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.meal.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: _toggleFavourite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
