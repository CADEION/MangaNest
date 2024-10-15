import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> favorites = prefs.getStringList('favorites') ?? [];
    final Map<String, double> ratings = {};

    
    for (String favorite in favorites) {
      ratings[favorite] = prefs.getDouble('$favorite-rating') ?? 0.0;
    }

    emit(FavoritesLoaded(favorites, ratings));
    print("Loaded favorites: $favorites");
  }

  Future<void> addFavorite(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites;

    if (state is FavoritesLoaded) {
      favorites = List<String>.from((state as FavoritesLoaded).favorites);
    } else {
      favorites = [];
    }

    if (!favorites.contains(title)) {
      favorites.add(title);
      await prefs.setStringList('favorites', favorites);
      emit(FavoritesLoaded(favorites, (state as FavoritesLoaded).ratings));
      print("Added to favorites: $title");
    } else {
      print("$title is already in favorites.");
    }
  }

  Future<void> updateRating(String title, double rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (state is FavoritesLoaded) {
      final favoritesState = state as FavoritesLoaded;
      final favorites = favoritesState.favorites;

      
      favoritesState.ratings[title] = rating;
      await prefs.setDouble('$title-rating', rating);
      emit(FavoritesLoaded(favorites, favoritesState.ratings));
      print("Updated rating for $title: $rating");
    }
  }
}
