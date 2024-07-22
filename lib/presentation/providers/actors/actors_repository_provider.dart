import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:try80/presentation/screens/barrel_screens.dart';

final actorsRepositoryProvider = Provider(
  (ref) {
    return ActorRepositoryImpl(datasource: ActorMovieDbDatasource());
  },
);
