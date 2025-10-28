import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../repository/data_repository.dart';

class AddEditPage extends StatefulWidget {
  static const routeName = '/add_edit';
  const AddEditPage({Key? key}) : super(key: key);

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  late DataRepository repo;
  final _form = GlobalKey<FormState>();
  bool isEdit = false;
  Movie? editing;

  final _judulController = TextEditingController();
  final _tahunController = TextEditingController();
  final _reviewController = TextEditingController();
  final _posterController = TextEditingController();

  String genre = '';
  String status = 'Ingin Ditonton';
  int rating = 3;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final argsRaw = ModalRoute.of(context)!.settings.arguments;

    repo = DataRepository();
    if (argsRaw is Map) {
      final id = argsRaw['id'] as int?;
      if (id != null) _loadMovie(id);
    } else if (argsRaw is int) {
      _loadMovie(argsRaw);
    }
  }

  void _loadMovie(int id) {
    final m = repo.getMovieById(id);
    if (m != null) {
      setState(() {
        isEdit = true;
        editing = m;
        _judulController.text = m.judul;
        genre = m.genre;
        status = m.status;
        _tahunController.text = m.tahun.toString();
        rating = m.rating;
        _reviewController.text = m.review;
        _posterController.text = m.poster;
      });
    }
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;

    final judul = _judulController.text.trim();
    final tahun = int.tryParse(_tahunController.text) ?? DateTime.now().year;
    final review = _reviewController.text.trim();
    final poster = _posterController.text.trim().isEmpty
        ? 'assets/posters/default.jpg'
        : _posterController.text.trim();

    if (genre.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Pilih genre terlebih dahulu')));
      return;
    }

    if (isEdit && editing != null) {
      final updated = Movie(
        id: editing!.id,
        judul: judul,
        tahun: tahun,
        genre: genre,
        rating: rating,
        status: status,
        review: review,
        poster: poster,
      );
      await repo.updateMovie(updated);
    } else {
      final newMovie = Movie(
        id: repo.nextMovieId(),
        judul: judul,
        tahun: tahun,
        genre: genre,
        rating: rating,
        status: status,
        review: review,
        poster: poster,
      );
      await repo.addMovie(newMovie);
    }

    await repo.reloadMovies(); // sinkron data
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(isEdit ? 'Edit Film' : 'Tambah Film'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  controller: _judulController,
                  decoration: _decoration('Judul Film'),
                  validator: (v) => v == null || v.isEmpty ? 'Judul tidak boleh kosong' : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: genre.isNotEmpty ? genre : null,
                  decoration: _decoration('Genre'),
                  dropdownColor: const Color(0xFF81D4FA),
                  items: ['Action', 'Comedy', 'Fantasy', 'Horror', 'Romance']
                      .map((g) => DropdownMenuItem(
                            value: g,
                            child: Text(g, style: const TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => genre = v ?? ''),
                  validator: (v) => v == null || v.isEmpty ? 'Pilih genre' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _tahunController,
                  decoration: _decoration('Tahun'),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    final year = int.tryParse(v ?? '');
                    if (v == null || v.isEmpty) return 'Tahun tidak boleh kosong';
                    if (year == null) return 'Masukkan tahun valid';
                    if (year < 1900 || year > 2100) return 'Tahun tidak valid';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: status,
                  decoration: _decoration('Status'),
                  dropdownColor: const Color(0xFF81D4FA),
                  items: ['Ingin Ditonton', 'Sedang Ditonton', 'Selesai Ditonton']
                      .map((s) => DropdownMenuItem(
                            value: s,
                            child: Text(s, style: const TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => status = v ?? status),
                ),
                const SizedBox(height: 12),
                // 🔹 Dropdown Rating bintang
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Text('Rating:', style: TextStyle(color: Colors.white, fontSize: 16)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButton<int>(
                          value: rating,
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          underline: const SizedBox(),
                          onChanged: (val) => setState(() => rating = val ?? rating),
                          items: List.generate(
                            5,
                            (index) => DropdownMenuItem<int>(
                              value: index + 1,
                              child: Row(
                                children: [
                                  Text('${index + 1}', style: const TextStyle(color: Colors.black)),
                                  const SizedBox(width: 8),
                                  ...List.generate(
                                    index + 1,
                                    (i) => const Icon(Icons.star, color: Colors.amber, size: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _reviewController,
                  decoration: _decoration('Review Singkat'),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _posterController,
                  decoration: _decoration('Path Poster (contoh: assets/posters/x.jpg)'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      );
}
