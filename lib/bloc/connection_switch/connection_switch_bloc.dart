import 'package:bloc/bloc.dart';
import 'package:challenge_flutter_2022/data/hive/switch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'connection_switch_event.dart';
part 'connection_switch_state.dart';

class ConnectionSwitchBloc
    extends Bloc<ConnectionSwitchEvent, ConnectionSwitchState> {
  ConnectionSwitchBloc() : super(ConnectionInitialState()) {
    Box<SwitchStatus> switchStatusBox = Hive.box('status');
    on<LoadConnectionEvent>((event, emit) async {
      try {
        if (event.statusSwitch) {
          SwitchStatus switchStatus = SwitchStatus(status: true);
          switchStatusBox.put(0, switchStatus);
          emit(ConnectedState());
        } else {
          SwitchStatus switchStatus = SwitchStatus(status: false);
          switchStatusBox.put(0, switchStatus);
          emit(DisconnectedState());
        }
      } catch (e) {
        emit(ConnectionErrorState(e.toString()));
      }
    });
  }
}
