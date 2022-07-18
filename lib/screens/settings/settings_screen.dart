import 'package:challenge_flutter_2022/bloc/connection_switch/connection_switch_bloc.dart';
import 'package:challenge_flutter_2022/constants/constants.dart';
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
            return _body(context, image: 'disabled', initialValue: false);
          }
          if (state is ConnectedState) {
            return _body(context, image: 'enabled', initialValue: true);
          }
          return Container();
        },
      ),
    );
  }

  Stack _body(BuildContext context,
      {required String image, required bool initialValue}) {
    return Stack(
      children: [
        Background(
          image: 'control-panel-$image.png',
        ),
        Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Connection status: ",
                  style: jholStyle.copyWith(fontSize: 18),
                ),
                Switch(
                  value: initialValue,
                  onChanged: (value) {
                    BlocProvider.of<ConnectionSwitchBloc>(context)
                        .add((LoadConnectionEvent(statusSwitch: value)));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.blueGrey[900],
                        content: Text(value
                            ? 'The connection is enabled, report the characters before they find you. Good luck to you.'
                            : 'The connection is disabled, they will not be able to find you. You are safe.'),
                      ),
                    );
                  },
                  activeTrackColor: Colors.cyanAccent,
                  activeColor: Colors.cyanAccent[700],
                  inactiveTrackColor: Colors.grey,
                  inactiveThumbColor: Colors.white,
                ),
              ],
            ),
            Text(
              initialValue ? 'connected' : 'disconnected',
              style: joutStyle.copyWith(
                  color: initialValue ? Colors.green : Colors.red,
                  fontSize: 30),
            ),
          ],
        ),
      ],
    );
  }
}
