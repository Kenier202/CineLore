import 'package:go_router/go_router.dart';
import 'package:try80/presentation/screens/movies/home_screen.dart';
import 'package:try80/presentation/screens/widgets/movies/movie_screen.dart';

final routes = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
        name: HomeScreen.name,
        path: "/",
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            name: MovieScreen.name,
            path: "movie/:id",
            builder: (context, state) {
              final movieId = state.pathParameters["id"] ?? "no-id";
              return MovieScreen(movieId: movieId);
            },
          ),
        ]),
  ],
);
