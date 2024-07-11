import 'package:try80/domain/datasources/movie_datasources.dart';
import 'package:try80/domain/entities/movie.dart';

class MovieDb extends MovieDatasource {
  @override
  Future<List<Movie>> getNowPlaying({int page = 0}) {
    // TODO: implement getNowPlaying
    throw UnimplementedError();
  }
}
