import 'package:cine_log/app/core/consts/api_urls.dart';
import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/notifier/default_listener_notifier.dart';
import 'package:cine_log/app/core/ui/theme_extensions.dart';
import 'package:cine_log/app/core/widget/user_message.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/modules/movies/movie_details/add_to_library_dialog.dart';
import 'package:cine_log/app/modules/movies/movie_details/movie_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum MovieAction {
  addToLibrary,
  markAsWatched,
}

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  final MovieAction action;
  const MovieDetailsPage({
    super.key,
    required this.movie,
    required this.action,
  });

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    super.initState();

    DefaultListenerNotifier(
            changeNotifier: context.read<MovieDetailsController>())
        .listener(
            context: context,
            everCallback: (notifier, listenerInstance) {
              if (notifier is MovieDetailsController) {
                if (notifier.hasInfo == true) {
                  UserMessage.of(context).showInfo(notifier.infoMessage!);
                }
              }
            },
            successCallback: (notifier, listener) {
              listener.dispose();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            });
  }

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
                        ApiUrls.posterUrl(widget.movie.posterPath),
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
                      widget.movie.displayTitle!,
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
                                text: widget.movie.releaseDate,
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
                              widget.movie.voteAverage?.toStringAsFixed(1) ??
                                  '0',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            Text(
                                '(${NumberFormat.compact().format(widget.movie.voteCount)} ${Messages.votes})'),
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
                            text:
                                '${widget.movie.overview}${widget.movie.overview}',
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
                      await showAddToLibraryDialog(context, widget.movie);

                  if (confirm == true) {
                    await context
                        .read<MovieDetailsController>()
                        .saveInLibrary(widget.movie);
                  }
                },
                child: Text(getButtonText()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getButtonText() {
    switch (widget.action) {
      case MovieAction.addToLibrary:
        return Messages.markAsWatched;

      case MovieAction.markAsWatched:
        return Messages.markAsWatched;
    }
  }
}
