import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorites_cubit.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded) {
            final favorites = state.favorites;

            if (favorites.isEmpty) {
              return Center(child: Text('No favorites saved yet!'));
            } else {
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 4.0,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        favorites[index],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(Icons.favorite, color: Colors.red),
                      onTap: () {},
                    ),
                  );
                },
              );
            }
          } else if (state is FavoritesError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('An error occurred.'));
          }
        },
      ),
    );
  }
}
