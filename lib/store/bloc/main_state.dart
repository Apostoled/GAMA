part of 'main_bloc.dart';

enum MainStatus { gamesLoaded, unknown }

class MainState extends Equatable {
  final MainStatus status;
  final List<Game> gamesList;

  const MainState._({
    this.status = MainStatus.unknown,
    this.gamesList = Game.empty,
  });

  const MainState.unknown() : this._();

  const MainState.gamesLoaded(List<Game> gamesList)
      : this._(
          status: MainStatus.gamesLoaded,
          gamesList: gamesList,
        );

  @override
  List<Object> get props => [status, gamesList];
}
