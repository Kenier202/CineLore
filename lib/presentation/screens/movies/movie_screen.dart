import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:try80/presentation/screens/barrel_screens.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static String name = "Movie screen";
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? getInfoMovie = ref.watch(movieInfoProvider)[widget.movieId];
    if (getInfoMovie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppbar(movie: getInfoMovie),
        ],
      ),
    );
  }
}

class _CustomSliverAppbar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppbar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      expandedHeight: size.height * 0.7,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          textAlign: TextAlign.start,
          style: const TextStyle(color: Colors.white),
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            const _Gradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            const _GradientTop(
              begin: Alignment.topLeft,
              end: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _Gradient extends StatelessWidget {
  final Alignment begin;
  final Alignment end;

  const _Gradient({required this.begin, required this.end});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: const [0.7, 1.0],
            colors: const [
              Colors.transparent,
              Colors.black87,
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientTop extends StatelessWidget {
  final Alignment begin;
  final Alignment end;

  const _GradientTop({required this.begin, required this.end});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: const [0.0, 0.3],
            colors: const [
              Colors.black87,
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
