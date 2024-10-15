part of 'favorites_cubit.dart'; 

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {} 

class FavoritesLoaded extends FavoritesState {
  final List<String> favorites;
  final Map<String, double> ratings; 

  FavoritesLoaded(this.favorites, this.ratings);
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
}
