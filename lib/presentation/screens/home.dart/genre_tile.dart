import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_detail_screen.dart';

class GenreTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  GenreTile(
      {required this.title, required this.imageUrl, required this.description});

  Future<void> _saveFavorite(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    if (!favorites.contains(title)) {
      favorites.add(title);
      await prefs.setStringList('favorites', favorites);

      
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              imageUrl: imageUrl,
              description: description,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.broken_image));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _saveFavorite(title);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$title added to favorites')),
                );
              },
              child: Text('Add to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
