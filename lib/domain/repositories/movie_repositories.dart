import 'package:try80/presentation/screens/barrel_screens.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
