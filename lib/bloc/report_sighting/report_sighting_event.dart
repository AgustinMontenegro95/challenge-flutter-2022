part of 'report_sighting_bloc.dart';

abstract class ReportSightingEvent extends Equatable {
  const ReportSightingEvent();

  @override
  List<Object> get props => [];
}

class LoadReportSightingEvent extends ReportSightingEvent {
  final String characterName;

  const LoadReportSightingEvent({required this.characterName});
  @override
  List<Object> get props => [];
}

class ResetReportSightingEvent extends ReportSightingEvent {
  const ResetReportSightingEvent();
  @override
  List<Object> get props => [];
}
