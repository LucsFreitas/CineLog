import 'package:cine_log/app/core/consts/api_urls.dart';
import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/notifier/default_listener_notifier.dart';
import 'package:cine_log/app/core/widget/movie_poster.dart';
import 'package:cine_log/app/core/widget/user_message.dart';
import 'package:cine_log/app/models/movie.dart';
import 'package:cine_log/app/modules/movies/movie_details/dialogs/confirm_dialog.dart';
import 'package:cine_log/app/modules/movies/movie_details/movie_details_controller.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum MovieAction { none, markAsWatched, reAddToLibrary, bothAdd }

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
    final movie = widget.movie;
    if (movie.homepage == null &&
        movie.runtime == null &&
        movie.genres == null) {
      final controller = context.read<MovieDetailsController>();
      await controller.loadData(widget.movie);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBarSize = mediaQuery.padding.top + kToolbarHeight;
    final totalHeight = mediaQuery.size.height;
    final backdropHeight = totalHeight * 0.22;

    final movie = widget.movie;
    final controller = context.read<MovieDetailsController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Messages.details,
        ),
        actions: [
          widget.action != MovieAction.bothAdd
              ? IconButton(
                  onPressed: () => _handleRemoveFromLibrary(context),
                  icon: Icon(Icons.delete_outline),
                )
              : SizedBox.shrink(),
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
                        child: movie.backdropPath != null &&
                                movie.backdropPath!.isNotEmpty
                            ? Image.network(
                                ApiUrls.backdropUrl(movie.backdropPath),
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/cinema.png',
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: totalHeight * 0.25,
                          child: Row(
                            children: [
                              SizedBox(
                                width: mediaQuery.size.width * 0.3,
                                child: MoviePoster(
                                  aspectRatio: 2 / 3,
                                  posterUrl:
                                      ApiUrls.posterUrl(movie.posterPath),
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
                                      movie.displayTitle!,
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
                                          movie.voteAverage
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
                                          '(${NumberFormat.compact().format(movie.voteCount)} ${Messages.votes})',
                                        ),
                                      ],
                                    ),
                                    movie.homepage?.trim().isNotEmpty == true
                                        ? InkWell(
                                            onTap: () async {
                                              await controller
                                                  .openUrl(movie.homepage!);
                                            },
                                            child: Text(
                                              Messages.oficialWebsite,
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
                        movie.watchedAt != null
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Text(formatWatchDate(movie.watchedAt!)),
                              )
                            : SizedBox.shrink(),
                        movie.genres != null && movie.genres!.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 6,
                                  alignment: WrapAlignment.center,
                                  children: movie.genres!
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
                            '${movie.overview}',
                            textAlign: TextAlign.justify,
                            maxLines: 4,
                            expandText: Messages.showMore,
                            collapseText: Messages.showLess,
                            animationDuration: Duration(seconds: 1),
                            expandOnTextTap: true,
                            collapseOnTextTap: true,
                            linkColor: Theme.of(context).colorScheme.primary,
                            prefixText: '${Messages.overview}: ',
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
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Builder(
          builder: (_) {
            switch (widget.action) {
              case MovieAction.bothAdd:
                return SpeedDial(
                  animatedIcon: AnimatedIcons.menu_close,
                  overlayColor: Colors.grey[700],
                  spacing: 10,
                  spaceBetweenChildren: 10,
                  children: [
                    SpeedDialChild(
                      child: Icon(Icons.bookmark_add_outlined),
                      label: Messages.addToLibrary,
                      onTap: () => _handleAddToLibrary(),
                    ),
                    SpeedDialChild(
                      child: Icon(Icons.check_circle_outline),
                      label: Messages.markAsWatched,
                      onTap: () => _handleMarkAsWatched(),
                    ),
                  ],
                );
              case MovieAction.markAsWatched:
                return FloatingActionButton.extended(
                  onPressed: _handleMarkAsWatched,
                  label: Row(
                    children: [Icon(Icons.check), Text(Messages.markAsWatched)],
                  ),
                );
              case MovieAction.reAddToLibrary:
                return FloatingActionButton.extended(
                  onPressed: _handleReAddToLibrary,
                  label: Row(
                    children: [
                      Icon(Icons.replay),
                      Text(Messages.reAddToLibrary)
                    ],
                  ),
                );
              case MovieAction.none:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Future<void> _handleRemoveFromLibrary(BuildContext context) async {
    final confirm = await confirmDialog(
      context: context,
      movie: widget.movie,
      title: Messages.removeFromLibraryTitle,
      text_1: Messages.removeFromLibraryText_1,
      text_2: Messages.removeFromLibraryText_2,
      invertButtons: true,
    );

    if (confirm == true) {
      await context
          .read<MovieDetailsController>()
          .removeFromLibrary(widget.movie);
    }
  }

  Future<void> _handleAddToLibrary() async {
    final confirm = await confirmDialog(
      context: context,
      movie: widget.movie,
      title: Messages.addToLibraryTitle,
      text_1: Messages.addToLibraryText_1,
      text_2: Messages.addToLibraryText_2,
      invertButtons: false,
    );

    if (confirm == true) {
      await context.read<MovieDetailsController>().saveInLibrary(widget.movie);
    }
  }

  Future<void> _handleReAddToLibrary() async {
    final confirm = await confirmDialog(
      context: context,
      movie: widget.movie,
      title: Messages.reAddToLibraryTitle,
      text_1: Messages.reAddToLibraryText_1,
      text_2: Messages.reAddToLibraryText_2,
      invertButtons: false,
    );

    if (confirm == true) {
      await context.read<MovieDetailsController>().saveInLibrary(widget.movie
        ..watched = 0
        ..watchedAt = null);
    }
  }

  Future<void> _handleMarkAsWatched() async {
    final confirm = await confirmDialog(
      context: context,
      movie: widget.movie,
      title: Messages.markAsWatched,
      text_1: Messages.markAsWatchedText_1,
      text_2: Messages.markAsWatchedText_2,
      invertButtons: false,
    );

    if (confirm == true) {
      await context.read<MovieDetailsController>().saveInLibrary(widget.movie
        ..watched = 1
        ..watchedAt = DateTime.now());
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
    if (runtime != null && runtime > 0) {
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

  String formatWatchDate(DateTime dateTime) {
    final now = DateTime.now();

    final time = DateFormat('HH:mm').format(dateTime);
    final date = dateTime.year == now.year
        ? DateFormat("d 'de' MMMM", 'pt_BR').format(dateTime)
        : DateFormat("dd/MM/yyyy").format(dateTime);
    return 'Assistido às $time de $date';
  }
}
