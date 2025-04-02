import 'dart:convert';

class Movie {
  int id;
  String? originalTitle;
  String? title;
  String? overview;
  String? posterPath;
  num? voteAverage;
  int? voteCount;
  String? releaseDate;
  DateTime? createdAt;

  Movie({
    required this.id,
    this.originalTitle,
    this.title,
    this.overview,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'original_title': originalTitle,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'release_date': releaseDate,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Movie.fromMap(Map<String, dynamic> map) => Movie(
        id: map['id'],
        originalTitle: map['original_title'],
        title: map['title'],
        overview: map['overview'],
        voteAverage: map['vote_average'],
        voteCount: map['vote_count'],
        posterPath: map['poster_path'],
        releaseDate: map['release_date'],
        createdAt: map['created_at'],
      );

  factory Movie.fromJson(String json) => Movie.fromMap(jsonDecode(json));
}
