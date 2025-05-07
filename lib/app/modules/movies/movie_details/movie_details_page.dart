import 'package:cine_log/app/core/consts/api_urls.dart';
import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/notifier/default_listener_notifier.dart';
import 'package:cine_log/app/core/widget/movie_poster.dart';
import 'package:cine_log/app/core/widget/user_message.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/modules/movies/movie_details/dialogs/add_to_library_dialog.dart';
import 'package:cine_log/app/modules/movies/movie_details/dialogs/remove_from_library_dialog.dart';
import 'package:cine_log/app/modules/movies/movie_details/movie_details_controller.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum MovieAction {
  addToLibrary,
  markAsWatched,
}

enum PopupMenuMoviePages {
  exclude,
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

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final controller = context.read<MovieDetailsController>();
    await controller.loadData(widget.movie);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MovieDetailsController>();

    final mediaQuery = MediaQuery.of(context);

    final appBarSize = mediaQuery.padding.top + kToolbarHeight;
    final totalHeight = mediaQuery.size.height;
    final backdropHeight = totalHeight * 0.22;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Messages.details,
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (PopupMenuMoviePages selected) async {
              switch (selected) {
                case PopupMenuMoviePages.exclude:
                  final confirm =
                      await showRemoveFromLibraryDialog(context, widget.movie);

                  if (confirm == true) {
                    await context
                        .read<MovieDetailsController>()
                        .removeFromLibrary(widget.movie);
                  }
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<PopupMenuMoviePages>>[
                PopupMenuItem<PopupMenuMoviePages>(
                  value: PopupMenuMoviePages.exclude,
                  child: Text(Messages.exclude),
                )
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                child: Stack(
                  children: [
                    SizedBox(
                      height: backdropHeight,
                      width: double.infinity,
                      child: Opacity(
                        opacity: 0.55,
                        child: Image.network(
                          ApiUrls.backdropUrl(widget.movie.backdropPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: backdropHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 1],
                          colors: [
                            Color.fromARGB(0, 255, 255, 255),
                            Color.fromARGB(255, 255, 255, 255),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: appBarSize * 1.2,
                        ),
                        // topo com poster
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: totalHeight * 0.25,
                          child: Row(
                            children: [
                              SizedBox(
                                width: mediaQuery.size.width * 0.3,
                                child: MoviePoster(
                                  aspectRatio: 2 / 3,
                                  posterUrl: ApiUrls.posterUrl(
                                      widget.movie.posterPath),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.movie.displayTitle!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      getYearAndRuntime(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          widget.movie.voteAverage
                                                  ?.toStringAsFixed(1) ??
                                              '0',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: Colors.amber[800],
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(Icons.star,
                                            color: Colors.amber[800], size: 20),
                                        Text(
                                          '(${NumberFormat.compact().format(widget.movie.voteCount)} ${Messages.votes})',
                                        ),
                                      ],
                                    ),
                                    widget.movie.homepage?.trim().isNotEmpty ==
                                            true
                                        ? InkWell(
                                            onTap: () async {
                                              await controller.openUrl(
                                                  widget.movie.homepage!);
                                            },
                                            child: Text(
                                              'Visite o site oficial',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.movie.genres != null
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 6,
                                  alignment: WrapAlignment.center,
                                  children: widget.movie.genres!
                                      .split(Movie.genreSeparator)
                                      .map((genre) => Chip(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 5),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            label: Text(
                                              genre,
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            backgroundColor: Colors.blue[50],
                                          ))
                                      .toList(),
                                ),
                              )
                            : SizedBox.shrink(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: ExpandableText(
                            '${widget.movie.overview}',
                            textAlign: TextAlign.justify,
                            maxLines: 4,
                            expandText: 'Mostrar mais',
                            collapseText: 'Mostrar menos',
                            animationDuration: Duration(seconds: 1),
                            expandOnTextTap: true,
                            collapseOnTextTap: true,
                            linkColor: Theme.of(context).colorScheme.primary,
                            prefixText: 'Sinopse: ',
                            animation: true,
                            prefixStyle: TextStyle(fontWeight: FontWeight.bold),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Botão de ação
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
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
    );
  }

  String getButtonText() {
    switch (widget.action) {
      case MovieAction.addToLibrary:
        return Messages.addToLibrary;

      case MovieAction.markAsWatched:
        return Messages.markAsWatched;
    }
  }

  String getYearAndRuntime() {
    final parts = <String>[];
    final releaseDate = widget.movie.releaseDate;
    final year = releaseDate != null
        ? DateTime.parse(releaseDate).year.toString()
        : null;
    if (year != null) parts.add(year);

    final runtime = widget.movie.runtime;
    if (runtime != null) {
      final hours = runtime ~/ 60;
      final minutes = runtime % 60;
      if (hours == 0) {
        parts.add('${minutes}min');
      } else if (minutes == 0) {
        parts.add('${hours}h');
      } else {
        parts.add('${hours}h ${minutes}min');
      }
    }

    return parts.join('  |  ');
  }
}
