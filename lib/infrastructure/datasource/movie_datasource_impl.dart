import 'package:dio/dio.dart';
import 'package:try80/infrastructure/models/moviedb/movie_details.dart';
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

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    List<Movie> movie = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map(
          (e) => MovieMapper.movieToMoviedb(e),
        )
        .toList();
    return movie;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception("id no encontrado");
    final movieDbResponse = MovieDetails.fromJson(response.data);

    Movie movieDetails = MovieMapper.movieDetailsToEntity(movieDbResponse);

    return movieDetails;
  }
}
