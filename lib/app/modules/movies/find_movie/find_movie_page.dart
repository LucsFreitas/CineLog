import 'dart:async';

import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/notifier/default_listener_notifier.dart';
import 'package:cine_log/app/core/widget/movie_card_horizontal.dart';
import 'package:cine_log/app/core/widget/user_message.dart';
import 'package:cine_log/app/modules/movies/find_movie/find_movie_controller.dart';
import 'package:cine_log/app/modules/movies/movie_details/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindMoviePage extends StatefulWidget {
  const FindMoviePage({super.key});

  @override
  State<FindMoviePage> createState() => _FindMoviePageState();
}

class _FindMoviePageState extends State<FindMoviePage> {
  bool typing = false;
  String insertedText = '';
  Timer? _debounce;

  final searchFieldController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    DefaultListenerNotifier(changeNotifier: context.read<FindMovieController>())
        .listener(
            context: context,
            everCallback: (notifier, listenerInstance) {
              if (notifier is FindMovieController) {
                if (notifier.hasInfo == true) {
                  UserMessage.of(context).showInfo(notifier.infoMessage!);
                }
              }
            },
            successCallback: (notifier, listener) {
              listener.dispose();
              Navigator.of(context).pop(context);
            });
    searchFieldController.addListener(_printLatestValue);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final controller = context.read<FindMovieController>();

    if (!controller.hasMorePages || controller.loading) {
      return;
    }

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      controller.loadData(searchFieldController.text);
    }
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _printLatestValue() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 800), () async {
      await context
          .read<FindMovieController>()
          .findByTitle(searchFieldController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchFieldController,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: Messages.searchInput,
            hintStyle: TextStyle(fontSize: 18, color: Colors.white70),
          ),
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<FindMovieController>(
        builder: (context, controller, child) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: controller.movies.length,
            itemBuilder: (context, index) {
              final movie = controller.movies[index];
              return MovieCardHorizontal(
                movie: movie,
                onTap: () => Navigator.of(context).pushNamed(
                  '/movie_details',
                  arguments: {
                    'action': MovieAction.bothAdd,
                    'movie': movie,
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
