import 'package:flutter/material.dart';
import '../models/film.dart';

class DetailScreen extends StatelessWidget {
  final Film film;
  final bool isFavorite;
  final void Function(Film film) onToggleFavorite;

  const DetailScreen({
    Key? key,
    required this.film,
    required this.isFavorite,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(film.title)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => onToggleFavorite(film),
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : null, // ❤️ berubah merah kalau favorit
        ),
        label: Text(isFavorite ? 'Hapus Favorit' : 'Tambah Favorit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Film → bisa diklik
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullScreenImage(imageUrl: film.poster),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  film.poster,
                  height: 420,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Judul
            Text(
              film.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),

            // Tahun & Genre
            Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.grey.shade700, size: 18),
                const SizedBox(width: 6),
                Text(film.year),
                const SizedBox(width: 16),
                Icon(Icons.local_movies, color: Colors.grey.shade700, size: 18),
                const SizedBox(width: 6),
                Expanded(child: Text(film.genre)),
              ],
            ),
            const SizedBox(height: 16),

            // Sinopsis
            const Text(
              'Sinopsis',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              film.synopsis,
              textAlign: TextAlign.justify,
              style: const TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔥 Halaman untuk Fullscreen Poster
class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context), // klik layar untuk kembali
        child: Center(
          child: InteractiveViewer( // bisa zoom in/out
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain, // biar tetap proporsional (potret)
            ),
          ),
        ),
      ),
    );
  }
}
