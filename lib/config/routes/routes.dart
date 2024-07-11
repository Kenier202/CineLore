import 'package:go_router/go_router.dart';
import 'package:try80/presentation/screens/movies/home_screen.dart';

final routes = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
