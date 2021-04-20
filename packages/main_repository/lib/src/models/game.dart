import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class Game extends Equatable {
  final String name;
  final String id;

  const Game({
    @required this.name,
    @required this.id,
  })  : assert(name != null),
        assert(id != null);

  static const empty = Game(name: '', id: '');
  static const emptyList = [Game(name: '', id: '')];

  @override
  List<Object> get props => [id, name];
}
