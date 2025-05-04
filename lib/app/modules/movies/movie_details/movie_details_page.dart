import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/ui/theme_extensions.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/modules/movies/movie_details/add_to_library_dialog.dart';
import 'package:cine_log/app/modules/movies/movie_details/movie_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

enum MovieAction {
  addToLibrary,
  markAsWatched,
  removeFromList,
}

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;
  final MovieAction action;
  const MovieDetailsPage({
    super.key,
    required this.movie,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    var appBarSize = mediaQuery.padding.top + kToolbarHeight;
    var heightBody = mediaQuery.size.height - appBarSize;

    return Scaffold(
      appBar: AppBar(
        title: Text(Messages.details),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: heightBody * .32,
                      child: Image.network(
                        context
                            .read<MovieDetailsController>()
                            .getEntirePostUrl(movie.posterPath),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/no_image_available.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      movie.displayTitle!,
                      style: context.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: '${Messages.releaseDate}:  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            children: [
                              TextSpan(
                                text: movie.releaseDate,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              movie.voteAverage?.toStringAsFixed(1) ?? '0',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            Text(
                                '(${NumberFormat.compact().format(movie.voteCount)} ${Messages.votes})'),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        text: '${Messages.overview}: ',
                        children: [
                          TextSpan(
                            text: '${movie.overview}${movie.overview}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: FilledButton(
                  onPressed: () async {
                    final confirm =
                        await showAddToLibraryDialog(context, movie);

                    if (confirm == true) {
                      context.loaderOverlay.show();
                      await context
                          .read<MovieDetailsController>()
                          .saveInLibrary(movie);
                      context.loaderOverlay.hide();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    }
                  },
                  child: Text(Messages.addToLibrary)),
            ),
          ],
        ),
      ),
    );
  }
}
