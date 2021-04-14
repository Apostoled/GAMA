part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class GamesListChanged extends MainEvent {
  final List<Game> games;
  const GamesListChanged(this.games);

  @override
  List<Object> get props => [games];
}


