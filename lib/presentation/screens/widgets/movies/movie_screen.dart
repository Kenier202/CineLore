import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  static String name = "Movie screen";
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("movies: $movieId"),
      ),
    );
  }
}
