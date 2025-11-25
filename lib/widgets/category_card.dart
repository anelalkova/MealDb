import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: ListTile(
        leading: Image.network(
          category.thumbnail,
          width: 70,
          fit: BoxFit.cover,
        ),
        title: Text(category.name),
        subtitle: Text(
          category.description.length > 70
              ? "${category.description.substring(0, 70)}..."
              : category.description,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            "/meals",
            arguments: category.name,
          );
        },
      ),
    );
  }
}
