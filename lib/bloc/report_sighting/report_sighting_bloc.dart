import 'package:bloc/bloc.dart';
import 'package:challenge_flutter_2022/data/repository/report_sighting_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'report_sighting_event.dart';
part 'report_sighting_state.dart';

class ReportSightingBloc
    extends Bloc<ReportSightingEvent, ReportSightingState> {
  final ReportSightingRepository _reportSightingRepository;
  ReportSightingBloc(this._reportSightingRepository)
      : super(ReportSightingInitialState()) {
    on<LoadReportSightingEvent>((event, emit) async {
      emit(ReportSightingLoadingState());
      try {
        final response = await _reportSightingRepository.reportSighting(
            characterName: event.characterName);
        emit(ReportSightingLoadedState(response!));
      } catch (e) {
        emit(ReportSightingErrorState(e.toString()));
      }
    });
    on<ResetReportSightingEvent>((event, emit) async {
      emit(ReportSightingInitialState());
    });
  }
}
