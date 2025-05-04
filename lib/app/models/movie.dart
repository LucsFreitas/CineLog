import 'dart:convert';

import 'package:cine_log/app/core/consts/texts.dart';

class Movie {
  int id;
  String? originalTitle;
  String? title;
  String? overview;
  String? posterPath;
  String? backdropPath;
  String? homepage;
  num? voteAverage;
  int? voteCount;
  int? runtime;
  String? releaseDate;
  int watched;
  DateTime? createdAt;
  DateTime? watchedAt;

  String? displayTitle;

  Movie({
    required this.id,
    this.originalTitle,
    this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.homepage,
    this.voteAverage,
    this.voteCount,
    this.runtime,
    this.releaseDate,
    this.watched = 0,
    this.createdAt,
    this.watchedAt,
    this.displayTitle,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'original_title': originalTitle,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'homepage': homepage,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'runtime': runtime,
      'release_date': releaseDate,
      'watched': watched,
      'created_at': createdAt?.toIso8601String(),
      'watched_at': watchedAt?.toIso8601String(),
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
      backdropPath: map['backdrop_path'],
      homepage: map['homepage'],
      runtime: map['runtime'],
      releaseDate: map['release_date'],
      watched: map['watched'] ?? 0,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      watchedAt:
          map['watched_at'] != null ? DateTime.parse(map['watched_at']) : null,
      displayTitle:
          map['title'] ?? map['originalTitle'] ?? Messages.titleNotAvailable);

  factory Movie.fromJson(String json) => Movie.fromMap(jsonDecode(json));
}
