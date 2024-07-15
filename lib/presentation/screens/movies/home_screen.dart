import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:try80/presentation/screens/barrel_screens.dart';

class HomeScreen extends StatelessWidget {
  static const name = "HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(getPopularMoviesProvider.notifier).loadNextPage();
    ref.read(getUpcomingMoviesProvider.notifier).loadNextPage();
    ref.read(getTopRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final getNowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final getPopularMovies = ref.watch(getPopularMoviesProvider);
    final getUpcomingMovies = ref.watch(getUpcomingMoviesProvider);
    final getTopRatedMovies = ref.watch(getTopRatedMoviesProvider);
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: CustomAppbar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSlideshow(movies: slideShowMovies),
                  MovieHorizontalListview(
                    movies: getNowPlayingMovies,
                    title: "En cines",
                    subtitle: "Viernes 12",
                    loadNextPage: () => ref
                        .read(nowPlayingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MovieHorizontalListview(
                    movies: getPopularMovies,
                    title: "Populares",
                    subtitle: "Ultimos dias",
                    loadNextPage: () => ref
                        .read(getPopularMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MovieHorizontalListview(
                    movies: getUpcomingMovies,
                    title: "Proximamente",
                    subtitle: "Este mes",
                    loadNextPage: () => ref
                        .read(getUpcomingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MovieHorizontalListview(
                    movies: getTopRatedMovies,
                    title: "Mejor calificadas",
                    subtitle: "De la historia",
                    loadNextPage: () => ref
                        .read(getTopRatedMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
