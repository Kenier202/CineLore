import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:try80/presentation/delegate/search_movie_delegate.dart';
import 'package:try80/presentation/providers/barrel_providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('CineLore', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: () {
                  final moviesRepository = ref.read(movieRepositoryProvider);
                  final searchProvider = ref.read(searchMovieProvider);

                  showSearch(
                    query: searchProvider,
                    context: context,
                    delegate: SearchMovieDelegate(
                      searchMovies: (query) {
                        ref
                            .read(searchMovieProvider.notifier)
                            .update((state) => query);
                        return moviesRepository.searchMovie(query);
                      },
                    ),
                  ).then(
                    (movie) {
                      if (movie == null) return;

                      context.push(
                        '/movie/${movie.id}',
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
