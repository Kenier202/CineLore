// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:try80/presentation/screens/barrel_screens.dart';

final getNowPlayingMovies = StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

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

    List<Movie> movies = await fetchMoreMovies(page: currenPage);
    state = [...movies, ...state];
  }
}
