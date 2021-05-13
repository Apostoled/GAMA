import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class Game extends Equatable {
  final String id;
  final String name;
  final String playersCount;
  final String avgTime;
  final bool enabled;

  const Game({
    @required this.name,
    @required this.id,
    @required this.playersCount,
    @required this.avgTime,
    @required this.enabled,
  })  : assert(name != null),
        assert(id != null),
        assert(playersCount != null),
        assert(enabled != null);

  static const empty =
      Game(name: '', id: '', playersCount: '', avgTime: '', enabled: false);
  static const emptyList = [
    Game(name: '', id: '', playersCount: '', avgTime: '', enabled: false)
  ];

  @override
  List<Object> get props => [id, name, playersCount, avgTime, enabled];
}
