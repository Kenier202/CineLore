import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:try80/presentation/screens/barrel_screens.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

    return MoviesNotifier(fetchMoreMovies);
  },
);

final getPopularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
    return MoviesNotifier(fetchMoreMovies);
  },
);

final getUpcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
    return MoviesNotifier(fetchMoreMovies);
  },
);

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  MovieCallback fetchMoreMovies;
  int currenPage = 0;

  MoviesNotifier(
    this.fetchMoreMovies,
  ) : super([]);

  Future<void> loadNextPage() async {
    currenPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currenPage);
    state = [...state, ...movies];
  }
}
