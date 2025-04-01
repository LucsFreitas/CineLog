import 'dart:convert';

class Movie {
  int id;
  String? originalTitle;
  String? title;
  String? overview;
  String? posterPath;
  num? voteAverage;
  DateTime? releaseDate;
  DateTime? createdAt;

  Movie({
    required this.id,
    this.originalTitle,
    this.title,
    this.overview,
    this.posterPath,
    this.voteAverage,
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
      'release_date': releaseDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  String toJson() => jsonEncode(toMap());

  factory Movie.fromMap(Map<String, dynamic> map) {
    DateTime? releaseDate;
    map['release_date'] = null;
    try {
      releaseDate = map['release_date']?.toString().isNotEmpty == true
          ? DateTime.tryParse(map['release_date'])
          : null;
    } catch (e) {
      releaseDate = null;
    }

    return Movie(
      id: map['id'],
      originalTitle: map['original_title'],
      title: map['title'],
      overview: map['overview'],
      voteAverage: map['vote_average'],
      posterPath: map['poster_path'],
      releaseDate: releaseDate,
      createdAt: map['created_at'],
    );
  }

  factory Movie.fromJson(String json) => Movie.fromMap(jsonDecode(json));
}
