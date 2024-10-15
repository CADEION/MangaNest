import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorites_cubit.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  DetailScreen(
      {required this.title, required this.imageUrl, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Image.network(imageUrl),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<FavoritesCubit>().addFavorite(title);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$title added to favorites!')),
              );
            },
            child: Text('Add to Favorites'),
          ),
        ],
      ),
    );
  }
}
