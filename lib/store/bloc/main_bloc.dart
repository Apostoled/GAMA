import 'dart:async';

import 'package:main_repository/main_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final MainRepository _mainRepository;
  StreamSubscription<List<Game>> _gamesSubsciption;

  MainBloc({
    @required MainRepository mainRepository,
  })  : assert(mainRepository != null),
        _mainRepository = mainRepository,
        super(const MainState.unknown()) {
    _gamesSubsciption = _mainRepository.games.listen(
      (games) => add(GamesListChanged(games)),
    );
  }

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is GamesListChanged) {
      yield _mapGamesListChangedToState(event);
    }
  }

  MainState _mapGamesListChangedToState(GamesListChanged event) {
    return event.gamesList != Game.empty
        ? MainState.gamesLoaded(event.gamesList)
        : const MainState.unknown();
  }

  @override
  Future<void> close() {
    _gamesSubsciption?.cancel();
    return super.close();
  }
}
