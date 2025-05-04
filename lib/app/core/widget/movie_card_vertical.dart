import 'package:cine_log/app/models/movie.dart';
import 'package:flutter/material.dart';

class MovieCardVertical extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;

  const MovieCardVertical({
    super.key,
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: movie.posterUrl != null && movie.posterUrl!.isNotEmpty
                  ? NetworkImage(movie.posterUrl!)
                  : AssetImage('assets/images/no_image_available.png')
                      as ImageProvider,
              onError: (_, __) =>
                  AssetImage('assets/images/no_image_available.png')
                      as ImageProvider,
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 70,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withAlpha(220)],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Text(
                  movie.displayTitle!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
