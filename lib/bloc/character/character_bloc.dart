import 'package:bloc/bloc.dart';
import 'package:challenge_flutter_2022/data/models/character_model.dart';
import 'package:challenge_flutter_2022/data/repository/character_respository.dart';
import 'package:equatable/equatable.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository _characterRepository;

  CharacterBloc(
    this._characterRepository,
  ) : super(CharacterLoadingState()) {
    on<LoadCharacterEvent>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        final characters = await _characterRepository.getCharacters(event.page);
        emit(CharacterLoadedState(characters));
      } catch (e) {
        emit(CharacterErrorState(e.toString()));
      }
    });
  }
}
