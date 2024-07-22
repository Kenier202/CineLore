import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:try80/presentation/providers/barrel_providers.dart';
import 'package:try80/presentation/screens/barrel_screens.dart';

final actorsMovieProvider =
    StateNotifierProvider<ActorsMovieNotifier, Map<String, List<Actor>>>(
  (ref) {
    final actorsRepository = ref.watch(actorsRepositoryProvider);

    return ActorsMovieNotifier(getActor: actorsRepository.getActorsById);
  },
);

typedef GetActorCallback = Future<List<Actor>> Function(String movieId);

class ActorsMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorCallback getActor;
  ActorsMovieNotifier({
    required this.getActor,
  }) : super({});

  Future<void> loadActor(String movieId) async {
    if (state[movieId] != null) return;

    final actor = await getActor(movieId);

    state = {...state, movieId: actor};
  }
}
