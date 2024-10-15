import 'package:anime_toon/presentation/screens/home.dart/favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/datasources/api_client.dart';
import 'genre_tile.dart';
import 'home_detail_screen.dart';
import 'home_model.dart'; // Ensure you import the correct HomeModel

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiClient _apiClient = ApiClient(); // Instantiate the ApiClient

  // Sample hardcoded genres
  final List<Map<String, String>> hardcodedGenres = [
    {
      'title': 'Lore Olympus',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSALK0yoNp6GCbvCWVhB1CgcYgS-QjbQvivkA&s',
      'description': 'Lore Olympus is a modern retelling of the story of Hades and Persephone.',
    },
    {
      'title': 'Tower of God',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4db9BFtNTQ_D6BmbmHae8FLyP65gm97j0Fg&s',
      'description': 'A boy enters a tower to find his friends and gain power.',
    },
  ];

  late Future<List<dynamic>> _apiGenres;

  @override
  void initState() {
    super.initState();
    _apiGenres = _fetchGenres();
  }

  Future<List<dynamic>> _fetchGenres() async {
    final homeModel = await _apiClient.fetchGenres();
    return homeModel.message?.result?.genreTabList?.genreTabs ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genres'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _apiGenres,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          
          final apiGenres = snapshot.data ?? [];
          final allGenres = [...hardcodedGenres, ...apiGenres];

          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: allGenres.length,
            itemBuilder: (context, index) {
              final genre = allGenres[index];
              return GenreTile(
                title: genre is Map<String, String> ? genre['title']! : genre.name ?? 'Unknown',
                imageUrl: genre is Map<String, String> ? genre['imageUrl']! : genre.iconImage ?? '',
                description: genre is Map<String, String> ? genre['description'] ?? '' : '',
              );
            },
          );
        },
      ),
    );
  }
}