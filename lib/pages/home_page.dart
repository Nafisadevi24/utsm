import 'package:flutter/material.dart';
import '../repository/data_repository.dart';
import '../models/movie_model.dart';
import 'add_edit_page.dart';
import 'detail_page.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repo = DataRepository();
  String username = '';

  @override
void initState() {
  super.initState();
  _initData();
}

Future<void> _initData() async {
  await repo.loadInitialData();
  await repo.reloadMovies();
  setState(() {});
}


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg is String) username = arg;
  }

  Future<void> refresh() async {
    await repo.reloadMovies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final movies = repo.getAllMovies();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB), Color(0xFF90CAF9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: Text(
                'CineLog+ ($username)',
                style: const TextStyle(
                  color: Color(0xFF0D47A1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  icon: const Icon(Icons.logout, color: Color(0xFF0D47A1)),
                ),
              ],
            ),
            Expanded(
  child: movies.isEmpty
      ? const Center(
          child: Text(
            'Belum ada film.\nTekan + untuk menambah.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF1565C0),
              fontSize: 16,
            ),
          ),
        )
      : ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: movies.length,
          itemBuilder: (ctx, i) {
            return GestureDetector(
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  DetailPage.routeName,
                  arguments: movies[i].id,
                );
                if (result == true) await refresh();
              },
              child: MovieCard(movie: movies[i]),
            );
          },
        ),
),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            AddEditPage.routeName,
          );
          if (result == true) await refresh();
        },
        backgroundColor: const Color(0xFF1E88E5),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
