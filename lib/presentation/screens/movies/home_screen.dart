import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:try80/presentation/screens/barrel_screens.dart';
import 'package:try80/presentation/screens/shared/custom_appbar.dart';
import 'package:try80/presentation/screens/widgets/movies/MoviesSlideshow.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final getNowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
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
                  MoviesSlideshow(movies: getNowPlayingMovies),
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
