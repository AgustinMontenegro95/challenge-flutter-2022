import 'package:bloc/bloc.dart';
import 'package:challenge_flutter_2022/data/models/character_model.dart';
import 'package:challenge_flutter_2022/data/repository/attributes_repository.dart';
import 'package:equatable/equatable.dart';

part 'attributes_event.dart';
part 'attributes_state.dart';

class AttributesBloc extends Bloc<AttributesEvent, AttributesState> {
  final AttributesRepository _attributesRepository;
  AttributesBloc(this._attributesRepository) : super(AttributesLoadingState()) {
    on<LoadAttributesEvent>((event, emit) async {
      emit(AttributesLoadingState());
      try {
        List<List<String>> vshNames = [];
        vshNames.add(
            await _attributesRepository.getVehiclesAttributes(event.character));
        vshNames.add(await _attributesRepository
            .getStarshipsAttributes(event.character));
        vshNames.add(await _attributesRepository
            .getHomeworldAttributes(event.character));
        emit(AttributesLoadedState(vshNames));
      } catch (e) {
        emit(AttributesErrorState(e.toString()));
      }
    });
  }
}
