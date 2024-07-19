import 'package:try80/presentation/screens/barrel_screens.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActorsById(String movieId);
}
