part of 'connection_switch_bloc.dart';

abstract class ConnectionSwitchEvent extends Equatable {
  const ConnectionSwitchEvent();

  @override
  List<Object> get props => [];
}

class LoadConnectionEvent extends ConnectionSwitchEvent {
  final bool statusSwitch;

  const LoadConnectionEvent({required this.statusSwitch});
  @override
  List<Object> get props => [];
}
