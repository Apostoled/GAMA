import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:main_repository/main_repository.dart';

part 'home_state.dart';

class GamesListCubit extends Cubit<GamesListState> {
  final MainRepository _mainRepository;

  GamesListCubit({
    @required MainRepository mainRepository,
  })  : assert(mainRepository != null),
        _mainRepository = mainRepository,
        super(GamesListLoadingState()) {
    fetchGamesList();
  }

  Future<void> fetchGamesList() async {
    try {
      emit(GamesListLoadingState());
      final List<Game> _loadedGamesList = await _mainRepository.getGamesList();
      _loadedGamesList == Game.emptyList
          ? emit(GamesListEmptyState())
          : emit(GamesListLoadedState(gamesList: _loadedGamesList));
    } catch (_) {
      emit(GamesListErrorState());
    }
  }
}
