part of 'connection_switch_bloc.dart';

abstract class ConnectionSwitchState extends Equatable {}

class ConnectionInitialState extends ConnectionSwitchState {
  @override
  List<Object?> get props => [];
}

class DisconnectedState extends ConnectionSwitchState {
  DisconnectedState();

  @override
  List<Object?> get props => [];
}

class ConnectedState extends ConnectionSwitchState {
  ConnectedState();

  @override
  List<Object?> get props => [];
}

class ConnectionErrorState extends ConnectionSwitchState {
  final String error;

  ConnectionErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
