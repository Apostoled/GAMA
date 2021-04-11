import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Game {
  final String name;
  final String id;

  Game({
    @required this.name,
    @required this.id,
  })  : assert(name != null),
        assert(id != null);
}
