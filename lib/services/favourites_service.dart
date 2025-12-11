import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/meal.dart';

class FavouritesService {
  static final _db = FirebaseFirestore.instance;
  static final _favCollection = _db.collection('favourites');

  static Future<void> addFavourite(Meal meal) async {
    await _favCollection.doc(meal.id).set({
      'name': meal.name,
      'thumbnail': meal.thumbnail,
      'id': meal.id,
    });
  }

  static Future<void> removeFavourite(Meal meal) async {
    await _favCollection.doc(meal.id).delete();
  }

  static Future<List<Meal>> getFavourites() async {
    final snapshot = await _favCollection.get();
    return snapshot.docs.map((doc) => Meal(
      id: doc['id'],
      name: doc['name'],
      thumbnail: doc['thumbnail'],
    )).toList();
  }

  static Future<bool> isFavourite(Meal meal) async {
    final doc = await _favCollection.doc(meal.id).get();
    return doc.exists;
  }
}
