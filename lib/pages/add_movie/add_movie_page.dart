import 'dart:async';

import 'package:cine_log/models/movie.dart';
import 'package:cine_log/services/movie_services.dart';
import 'package:flutter/material.dart';

class AddMoviePage extends StatefulWidget {
  const AddMoviePage({super.key});

  @override
  State<AddMoviePage> createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  bool typing = false;
  String insertedText = '';
  Timer? _debounce;
  List<Movie> movies = [];

  final searchFieldController = TextEditingController();
  final movieServices = MovieServices();

  @override
  void initState() {
    super.initState();
    searchFieldController.addListener(_printLatestValue);
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
      print('entrou no cancelamento');
    }

    final text = searchFieldController.text.trim();
    if (text.isEmpty) {
      movies = [];
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 800), () async {
      print('buscou filmes');
      var result = await movieServices.findByTitle(text, '1');
      setState(() {
        movies = result;
      });
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
            hintText: 'Pesquisar...',
            hintStyle: TextStyle(fontSize: 18, color: Colors.white70),
          ),
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: movies.length,
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
            color: Colors.grey,
          );
        },
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              movieServices.getEntirePostUrl(movies[index].posterPath),
              width: 50,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/no_image_available.png',
                    width: 50, height: 50, fit: BoxFit.cover);
              },
            ),
            title: Text(movies[index].title),
            subtitle: Text(
              movies[index].overview,
              maxLines: 3,
            ),
          );
        },
      ),
    );
  }
}
