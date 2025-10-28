import 'package:flutter/material.dart';
import '../repository/data_repository.dart';
import 'add_edit_page.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repo = DataRepository();
    final id = ModalRoute.of(context)!.settings.arguments as int?;
    final movie = repo.getMovieById(id ?? 0);

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: Text('Film tidak ditemukan', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB3E5FC), Color(0xFF81D4FA), Color(0xFF0288D1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(movie.judul),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  AddEditPage.routeName,
                  arguments: {'id': movie.id, 'repo': repo},
                );
                if (result == true) {
                  await repo.reloadMovies();
                  Navigator.pop(context, true);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Hapus Film?'),
                    content: Text('Yakin mau hapus "${movie.judul}"?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  await repo.deleteMovie(movie.id);
                  await repo.reloadMovies();
                  Navigator.pop(context, true);
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  movie.poster,
                  height: 250,
                  width: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.movie, color: Colors.white, size: 60),
                ),
              ),
              const SizedBox(height: 16),
              Text(movie.judul,
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('${movie.genre} • ${movie.tahun}',
                  style: const TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(movie.rating,
                      (_) => const Icon(Icons.star, color: Colors.amber, size: 24)),
                  const SizedBox(width: 8),
                  Text('${movie.rating}/5',
                      style: const TextStyle(color: Colors.white70, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 16),
              Text(movie.status,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              Text(movie.review.isNotEmpty ? movie.review : 'Belum ada review.',
                  style: const TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
