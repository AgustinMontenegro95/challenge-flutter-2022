part of 'attributes_bloc.dart';

abstract class AttributesEvent extends Equatable {
  const AttributesEvent();

  @override
  List<Object> get props => [];
}

class LoadAttributesEvent extends AttributesEvent {
  final CharacterModel character;

  const LoadAttributesEvent({required this.character});
  @override
  List<Object> get props => [];
}
