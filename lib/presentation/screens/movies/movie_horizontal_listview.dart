// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:try80/config/helpers/humarn_formats.dart';
import 'package:try80/presentation/screens/barrel_screens.dart';

class MovieHorizontalListview extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final List<Movie> movies;
  final VoidCallback? loadNextPage;
  const MovieHorizontalListview(
      {super.key,
      this.title,
      this.subtitle,
      required this.movies,
      this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(
              subtitle: widget.subtitle,
              title: widget.title,
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _Slide(
                  movie: widget.movies[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? subtitle;
  final String? title;

  const _Title({
    this.subtitle,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: textStyle),
          const Spacer(),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton.tonal(
                onPressed: () {},
                child: Text(subtitle!),
              ),
            ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      context.push("/movie/${movie.id}");
                    },
                    child: FadeIn(child: child),
                  );
                },
              ),
            ),
          ),
          SizedBox(
              width: 150,
              child: Row(
                children: [
                  Icon(
                    Icons.star_border,
                    color: Colors.yellow.shade800,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('${movie.voteAverage}'),
                  const Spacer(),
                  Text(
                    HumanFormats.numbers(movie.popularity),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
