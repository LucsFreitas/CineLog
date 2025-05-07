import 'dart:convert';

import 'package:cine_log/app/models/movie.dart';

class MovieDetailsResponse {
  String? genres;
  String? homepage;
  int? runtime;

  MovieDetailsResponse({
    this.homepage,
    this.genres,
    this.runtime,
  });

  Map<String, dynamic> toMap() {
    return {
      'homepage': homepage,
      'genres': genres,
      'runtime': runtime,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory MovieDetailsResponse.fromMap(Map<String, dynamic> map) =>
      MovieDetailsResponse(
        homepage: map['homepage'],
        runtime: map['runtime'],
        genres: (map['genres'] as List)
            .map((genre) => genre['name'])
            .join(Movie.genreSeparator),
      );

  factory MovieDetailsResponse.fromJson(String json) =>
      MovieDetailsResponse.fromMap(jsonDecode(json));
}
