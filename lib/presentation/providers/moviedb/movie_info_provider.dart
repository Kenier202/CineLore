import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:try80/domain/entities/movie.dart';
import 'package:try80/presentation/providers/moviedb/movies_repository_provider.dart';

final movieInfoProvider = StateNotifierProvider(
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

    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
