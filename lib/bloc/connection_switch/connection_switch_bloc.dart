import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'connection_switch_event.dart';
part 'connection_switch_state.dart';

class ConnectionSwitchBloc
    extends Bloc<ConnectionSwitchEvent, ConnectionSwitchState> {
  ConnectionSwitchBloc() : super(ConnectionInitialState()) {
    on<LoadConnectionEvent>((event, emit) async {
      try {
        if (event.statusSwitch) {
          emit(ConnectedState());
        } else {
          emit(DisconnectedState());
        }
      } catch (e) {
        emit(ConnectionErrorState(e.toString()));
      }
    });
  }
}
