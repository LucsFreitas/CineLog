import 'dart:async';

import 'package:flutter/material.dart';

class AddMoviePage extends StatefulWidget {
  const AddMoviePage({super.key});

  @override
  State<AddMoviePage> createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  bool typing = false;
  String insertedText = 'inicio';
  Timer? _debounce;

  final searchFieldController = TextEditingController();

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
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 800), () {
      final text = searchFieldController.text;
      setState(() {
        insertedText = text;
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
      body: Center(
        child: Text(insertedText),
      ),
    );
  }
}
