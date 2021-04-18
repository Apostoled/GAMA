part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class GamesListChanged extends MainEvent {
  final List<Game> gamesList;
  const GamesListChanged(this.gamesList);

  @override
  List<Object> get props => [gamesList];
}


