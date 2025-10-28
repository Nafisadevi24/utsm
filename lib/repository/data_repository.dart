import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';
import '../models/movie_model.dart';
import '../models/user_model.dart';

class DataRepository {
  static final DataRepository _instance = DataRepository._internal();
  factory DataRepository() => _instance;
  DataRepository._internal();

  final _storage = LocalStorage('cinelog_data.json');

  List<User> users = [];
  List<Movie> movies = [];

  static const String _moviesKey = 'movies_data';
  static const String _usersKey = 'users_data';

  /// 🟢 Muat data awal
  Future<void> loadInitialData() async {
    if (kIsWeb) {
      await _storage.ready;
      final storedMovies = _storage.getItem(_moviesKey);
      final storedUsers = _storage.getItem(_usersKey);

      if (storedMovies != null && storedUsers != null) {
        movies = (storedMovies as List)
            .map((e) => Movie.fromJson(e as Map<String, dynamic>))
            .toList();
        users = (storedUsers as List)
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        await _loadFromAssets(); // jika belum ada data
        await _saveAll();
      }
      return;
    }

    // 🟢 Android/iOS/Windows pakai SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    final usersData = prefs.getString(_usersKey);
    final moviesData = prefs.getString(_moviesKey);

    if (usersData != null && moviesData != null) {
      final List ulist = json.decode(usersData);
      final List mlist = json.decode(moviesData);
      users = ulist.map((e) => User.fromJson(e)).toList();
      movies = mlist.map((e) => Movie.fromJson(e)).toList();
    } else {
      await _loadFromAssets();
      await _saveAll();
    }
  }

  /// 🔹 Muat dari assets default (pertama kali)
  Future<void> _loadFromAssets() async {
    final usersJson = await rootBundle.loadString('assets/users.json');
    final moviesJson = await rootBundle.loadString('assets/movies.json');

    final List ulist = json.decode(usersJson);
    final List mlist = json.decode(moviesJson);

    users = ulist.map((e) => User.fromJson(e)).toList();
    movies = mlist.map((e) => Movie.fromJson(e)).toList();
  }

  /// 🔹 Simpan semua data
  Future<void> _saveAll() async {
    if (kIsWeb) {
      await _storage.ready;
      _storage.setItem(
          _moviesKey, movies.map((m) => m.toJson()).toList());
      _storage.setItem(
          _usersKey, users.map((u) => u.toJson()).toList());
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          _moviesKey, json.encode(movies.map((m) => m.toJson()).toList()));
      await prefs.setString(
          _usersKey, json.encode(users.map((u) => u.toJson()).toList()));
    }
  }

  // ---------------- AUTH ----------------
  User? authenticate(String username, String password) {
    try {
      return users.firstWhere(
        (u) => u.username == username && u.password == password,
      );
    } catch (e) {
      return null;
    }
  }

  bool usernameExists(String username) {
    return users.any((u) => u.username == username);
  }

  Future<void> registerUser(String username, String password) async {
    users.add(User(username: username, password: password));
    await _saveAll();
  }

  // ---------------- MOVIE CRUD ----------------
  List<Movie> getAllMovies() => movies;

  Movie? getMovieById(int id) {
    try {
      return movies.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addMovie(Movie m) async {
    movies.add(m);
    await _saveAll();
  }

  Future<void> updateMovie(Movie updated) async {
    final idx = movies.indexWhere((m) => m.id == updated.id);
    if (idx != -1) {
      movies[idx] = updated;
      await _saveAll();
    }
  }

  Future<void> deleteMovie(int id) async {
    movies.removeWhere((m) => m.id == id);
    await _saveAll();
  }

  int nextMovieId() {
    if (movies.isEmpty) return 1;
    return movies.map((m) => m.id).reduce((a, b) => a > b ? a : b) + 1;
  }

  Future<void> reloadMovies() async {
    if (kIsWeb) {
      await _storage.ready;
      final stored = _storage.getItem(_moviesKey);
      if (stored != null) {
        movies = (stored as List)
            .map((e) => Movie.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } else {
      final prefs = await SharedPreferences.getInstance();
      final moviesData = prefs.getString(_moviesKey);
      if (moviesData != null && moviesData.isNotEmpty) {
        final List mlist = json.decode(moviesData);
        movies = mlist.map((e) => Movie.fromJson(e)).toList();
      }
    }
  }

  Future<void> resetToDefault() async {
    await _loadFromAssets();
    await _saveAll();
  }
}
