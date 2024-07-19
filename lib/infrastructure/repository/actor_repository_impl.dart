import 'package:try80/domain/repositories/actors_repository.dart';
import 'package:try80/presentation/screens/barrel_screens.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl({required this.datasource});
  @override
  Future<List<Actor>> getActorsById(String movieId) {
    return datasource.getActorsById(movieId);
  }
}
