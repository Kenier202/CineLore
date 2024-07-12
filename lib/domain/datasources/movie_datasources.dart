import 'package:try80/presentation/screens/barrel_screens.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
