import 'package:try80/domain/entities/actor.dart';
import 'package:try80/presentation/screens/barrel_screens.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id.toString(),
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg',
        character: cast.character,
      );
}
