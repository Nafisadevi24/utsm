class Movie {
  int id;
  String judul;
  int tahun;
  String genre;
  int rating;
  String status;
  String review;
  String poster; 

  Movie({
    required this.id,
    required this.judul,
    required this.tahun,
    required this.genre,
    required this.rating,
    required this.status,
    required this.review,
    required this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> j) => Movie(
        id: j['id'],
        judul: j['judul'],
        tahun: j['tahun'],
        genre: j['genre'],
        rating: j['rating'],
        status: j['status'],
        review: j['review'],
        poster: j['poster'] ?? 'assets/posters/default.jpg',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        'tahun': tahun,
        'genre': genre,
        'rating': rating,
        'status': status,
        'review': review,
        'poster': poster,
      };
}
