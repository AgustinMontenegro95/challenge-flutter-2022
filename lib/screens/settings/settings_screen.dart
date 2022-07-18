import 'package:challenge_flutter_2022/bloc/connection_switch/connection_switch_bloc.dart';
import 'package:challenge_flutter_2022/screens/widgets/app_bar.dart';
import 'package:challenge_flutter_2022/screens/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context, title: "Settings menu"),
      body: BlocBuilder<ConnectionSwitchBloc, ConnectionSwitchState>(
        builder: (context, state) {
          if (state is DisconnectedState) {
            return Stack(
              children: [
                const Background(
                  image: 'control-panel-enabled.png',
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
                    _connectionSwitch(context, initialValue: false),
                  ],
                ),
              ],
            );
          }
          if (state is ConnectedState) {
            return Stack(
              children: [
                const Background(
                  image: 'control-panel-disabled.png',
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
                    _connectionSwitch(context, initialValue: true),
                  ],
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _connectionSwitch(BuildContext context, {required bool initialValue}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Connection status: ",
          style: TextStyle(color: Colors.white),
        ),
        Switch(
          value: initialValue,
          onChanged: (value) {
            BlocProvider.of<ConnectionSwitchBloc>(context)
                .add((LoadConnectionEvent(statusSwitch: value)));
          },
          activeTrackColor: Colors.blueAccent,
          activeColor: Colors.blue,
        ),
      ],
    );
  }
}
