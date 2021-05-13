part of 'home_cubit.dart';

abstract class GamesListState extends Equatable {
  const GamesListState();
  @override
  List<Object> get props => [];
}

class GamesListEmptyState extends GamesListState {}

class GamesListLoadingState extends GamesListState {}

class GamesListLoadedState extends GamesListState {
  final List<Game> gamesList;

  const GamesListLoadedState({@required this.gamesList})
      : assert(gamesList != null);

  @override
  List<Object> get props => [gamesList];
}

class GamesListErrorState extends GamesListState {}
