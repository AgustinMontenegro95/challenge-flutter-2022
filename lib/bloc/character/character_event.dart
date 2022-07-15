part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class LoadCharacterEvent extends CharacterEvent {
  final int page;

  const LoadCharacterEvent(this.page);

  @override
  List<Object> get props => [];
}
