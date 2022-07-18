part of 'report_sighting_bloc.dart';

abstract class ReportSightingState extends Equatable {}

class ReportSightingInitialState extends ReportSightingState {
  @override
  List<Object?> get props => [];
}

class ReportSightingLoadingState extends ReportSightingState {
  @override
  List<Object?> get props => [];
}

class ReportSightingLoadedState extends ReportSightingState {
  final http.Response response;
  ReportSightingLoadedState(this.response);

  @override
  List<Object?> get props => [];
}

class ReportSightingErrorState extends ReportSightingState {
  final String error;

  ReportSightingErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
