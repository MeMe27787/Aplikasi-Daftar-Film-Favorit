import 'package:flutter/material.dart';
import '../models/film.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Film> favoriteFilms;
  final void Function(Film film) onToggleFavorite;

  const FavoritesScreen({
    Key? key,
    required this.favoriteFilms,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Film Favorit"),
        centerTitle: true,
      ),
      body: favoriteFilms.isEmpty
          ? const Center(
              child: Text(
                "Belum ada film favorit",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: favoriteFilms.length,
              itemBuilder: (context, index) {
                final film = favoriteFilms[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Image.network(
                      film.poster,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(film.title),
                    subtitle: Text("Tahun: ${film.year}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            film: film,
                            isFavorite: true,
                            onToggleFavorite: onToggleFavorite,
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
