import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:try80/domain/entities/movie.dart';
import 'package:try80/presentation/providers/barrel_providers.dart';

final moviesSlideShowProvider = Provider<List<Movie>>(
  (ref) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    if (nowPlayingMovies.isEmpty) return [];

    return nowPlayingMovies.sublist(0, 6);
  },
);
