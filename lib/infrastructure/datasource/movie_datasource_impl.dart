import 'package:dio/dio.dart';
import 'package:try80/presentation/screens/barrel_screens.dart';

class MoviedbDatasource extends MovieDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'es-MX'
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 0}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {"page": page},
    );

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    List<Movie> movie = movieDbResponse.results
        .map(
          (e) => MovieMapper.movieToMoviedb(e),
        )
        .toList();

    return movie;
  }
}
