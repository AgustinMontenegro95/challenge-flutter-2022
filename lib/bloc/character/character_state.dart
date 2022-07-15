part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {}

//characters

class CharacterLoadingState extends CharacterState {
  @override
  List<Object?> get props => [];
}

class CharacterLoadedState extends CharacterState {
  final List<CharacterModel> character;

  CharacterLoadedState(this.character);

  @override
  List<Object?> get props => [];
}

class CharacterErrorState extends CharacterState {
  final String error;

  CharacterErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
