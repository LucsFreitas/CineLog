import 'package:cine_log/app/core/consts/api_urls.dart';
import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/ui/theme_extensions.dart';
import 'package:cine_log/app/core/widget/movie_poster.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:flutter/material.dart';

class MovieCardHorizontal extends StatelessWidget {
  final VoidCallback? onTap;

  const MovieCardHorizontal({
    super.key,
    required this.movie,
    this.onTap,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: MoviePoster(
                  posterUrl: ApiUrls.posterUrl(movie.posterPath),
                  aspectRatio: 3 / 4,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.displayTitle!,
                        style: context.textTheme.titleMedium),
                    Text(
                      movie.overview ?? Messages.overviewNotAvailable,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
