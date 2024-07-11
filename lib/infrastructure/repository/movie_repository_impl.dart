import 'package:try80/presentation/screens/barrel_screens.dart';

class MovieRepositoryImpl extends MoviesRepository {
  MovieDatasource datasource;
  MovieRepositoryImpl({
    required this.datasource,
  });
  @override
  Future<List<Movie>> getNowPlaying({int page = 0}) {
    return datasource.getNowPlaying(page: page);
  }
}
