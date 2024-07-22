import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:try80/presentation/providers/barrel_providers.dart';
import 'package:try80/presentation/screens/barrel_screens.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>(
  (ref) {
    final movieRepository = ref.watch(movieRepositoryProvider);

    return MovieMapNotifier(getMovie: movieRepository.getMovieById);
  },
);

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;
  MovieMapNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    debugPrint("cargando nuevo id");
    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
