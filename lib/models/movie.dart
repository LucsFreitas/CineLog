import 'dart:convert';

class Movie {
  int id;
  String originalTitle;
  String title;
  String overview;
  String posterPath;

  Movie({
    required this.id,
    required this.originalTitle,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      originalTitle: map['original_title'] ?? 'Título não disponível',
      title: map['title'] != null && map['title']?.isNotEmpty == true
          ? map['title']
          : map['original_title'],
      overview: map['overview']?.isNotEmpty
          ? map['overview']
          : 'Sinopse não disponível',
      posterPath: map['poster_path'] ?? '',
    );
  }

  factory Movie.fromJson(String json) => Movie.fromMap(jsonDecode(json));
}
