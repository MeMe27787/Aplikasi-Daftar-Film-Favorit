import 'package:flutter/material.dart';
import '../data/film.dart';
import '../models/film.dart';
import 'detail_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<String> _favoriteTitles = <String>{};

  void _toggleFavorite(Film film) {
    setState(() {
      if (_favoriteTitles.contains(film.title)) {
        _favoriteTitles.remove(film.title);
      } else {
        _favoriteTitles.add(film.title);
      }
    });
  }

  bool _isFavorite(Film film) => _favoriteTitles.contains(film.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Film'),
        actions: [
          IconButton(
            tooltip: 'Lihat Favorit',
            icon: const Icon(Icons.favorite),
            onPressed: () {
              final favFilms = films
                  .where((f) => _favoriteTitles.contains(f.title))
                  .toList();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesScreen(
                    favoriteFilms: favFilms,   // ✅ disamakan dengan FavoritesScreen
                    onToggleFavorite: _toggleFavorite,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Image.asset(
                film.poster,
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(film.title),
              subtitle: Text("Tahun: ${film.year}"),
              trailing: Icon(
                _isFavorite(film) ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite(film) ? Colors.red : null,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(
                      film: film,
                      isFavorite: _isFavorite(film),
                      onToggleFavorite: _toggleFavorite,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
