part of 'main_bloc.dart';

enum MainStatus { gamesLoaded, unknown }

class MainState extends Equatable {
  final MainStatus status;
  final List<Game> games;

  const MainState._({
    this.status = MainStatus.unknown,
    this.games = Game.empty,
  });

  const MainState.unknown() : this._();

  const MainState.gamesLoaded(List<Game> games)
      : this._(
          status: MainStatus.gamesLoaded,
          games: games,
        );

  @override
  List<Object> get props => [status, games];
}
