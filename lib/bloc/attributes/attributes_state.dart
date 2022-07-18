part of 'attributes_bloc.dart';

abstract class AttributesState extends Equatable {}

class AttributesLoadingState extends AttributesState {
  @override
  List<Object?> get props => [];
}

class AttributesLoadedState extends AttributesState {
  final List<List<String>> attributes;

  AttributesLoadedState(this.attributes);

  @override
  List<Object?> get props => [];
}

class AttributesErrorState extends AttributesState {
  final String error;

  AttributesErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
