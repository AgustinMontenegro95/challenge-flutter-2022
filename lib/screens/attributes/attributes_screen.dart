import 'dart:convert';

import 'package:challenge_flutter_2022/bloc/attributes/attributes_bloc.dart';
import 'package:challenge_flutter_2022/bloc/connection_switch/connection_switch_bloc.dart';
import 'package:challenge_flutter_2022/bloc/report_sighting/report_sighting_bloc.dart';
import 'package:challenge_flutter_2022/constants/constants.dart';
import 'package:challenge_flutter_2022/data/models/character_model.dart';
import 'package:challenge_flutter_2022/screens/widgets/app_bar.dart';
import 'package:challenge_flutter_2022/screens/widgets/background.dart';
import 'package:challenge_flutter_2022/screens/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class AttributesScreen extends StatelessWidget {
  const AttributesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parameters = ModalRoute.of<Object?>(context)!.settings.arguments;
    CharacterModel characterModel = parameters as CharacterModel;
    return BlocBuilder<AttributesBloc, AttributesState>(
      builder: (context, state) {
        if (state is AttributesLoadingState) {
          return const Loading(
            background: 'background-home.png',
            topText: 'Loading character attributes',
            bottomText: 'wait a moment',
            lottie: 'loading-starship',
          );
        }
        if (state is AttributesLoadedState) {
          final attributes = state.attributes;
          //atributes[0] vehicles
          //atributes[1] starships
          //atributes[2] homeworld
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: appBar(context, title: "Attributes"),
            floatingActionButton: _sightingReportButton(characterModel),
            body: Stack(
              children: [
                const Background(image: 'background-attributes.png'),
                SafeArea(
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _cardAttribute(context,
                              attribute: "Name", value: characterModel.name),
                          _cardAttribute(context,
                              attribute: "Birth year",
                              value: characterModel.birthYear),
                          _cardAttribute(context,
                              attribute: "Gender",
                              value: characterModel.gender),
                          _cardAttribute(context,
                              attribute: "Homeworld", value: attributes[2][0]),
                          _cardAttribute(context,
                              attribute: "Height",
                              value: characterModel.height),
                          _cardAttribute(context,
                              attribute: "Mass", value: characterModel.mass),
                          _cardAttribute(context,
                              attribute: "Hair color",
                              value: characterModel.hairColor),
                          _cardAttribute(context,
                              attribute: "Eye color",
                              value: characterModel.eyeColor),
                          _cardVehiclesAttribute(context,
                              attributes: attributes[0], attribute: "Vehicles"),
                          _cardVehiclesAttribute(context,
                              attributes: attributes[1],
                              attribute: "Starships"),
                          const SizedBox(height: 70),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is AttributesErrorState) {
          return Center(
            child: Text(state.error.toString()),
          );
        }
        return Container();
      },
    );
  }

  Widget _sightingReportButton(CharacterModel characterModel) {
    return BlocBuilder<ReportSightingBloc, ReportSightingState>(
      builder: (context, stateReportSighting) {
        if (stateReportSighting is ReportSightingInitialState) {
          return BlocBuilder<ConnectionSwitchBloc, ConnectionSwitchState>(
            builder: (context, stateConnection) {
              if (stateConnection is DisconnectedState) {
                return FloatingActionButton.extended(
                    backgroundColor: Colors.grey,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.blueGrey[900],
                        content: const Text('The connection is disabled'),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          textColor: Colors.amber,
                          label: 'Activate'.toUpperCase(),
                          onPressed: () {
                            Navigator.pushNamed(context, "/settings");
                          },
                        ),
                      ));
                    },
                    label: Text("Sighting report".toUpperCase()));
              }
              if (stateConnection is ConnectedState) {
                return FloatingActionButton.extended(
                  backgroundColor: Colors.blue.withOpacity(0.3),
                  onPressed: () {
                    BlocProvider.of<ReportSightingBloc>(context).add(
                      LoadReportSightingEvent(
                        characterName: characterModel.name,
                      ),
                    );
                  },
                  label: Text("Sighting report".toUpperCase()),
                );
              }
              return Container();
            },
          );
        }
        if (stateReportSighting is ReportSightingLoadingState) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: FloatingActionButton(
                backgroundColor: Colors.blue.withOpacity(0.3),
                onPressed: null,
                child: const CircularProgressIndicator(color: Colors.white)),
          );
        }
        if (stateReportSighting is ReportSightingLoadedState) {
          Response response = stateReportSighting.response;
          Map<String, dynamic> data =
              jsonDecode(utf8.decode(response.bodyBytes));
          return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: AlertDialog(
              alignment: Alignment.centerRight,
              backgroundColor: Colors.black,
              title: Text(
                'Sighting report'.toLowerCase(),
                style: titleStyle,
              ),
              content: response.statusCode == 201
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: 'Status: ', style: jediStyle),
                              TextSpan(
                                text: 'ok',
                                style: jediStyle.copyWith(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        Text('Character: ${data['character_name']}',
                            style: jediStyle),
                        Text(
                            'Date: ${data['dateTime'].toString().substring(0, 19)}',
                            style: jediStyle),
                        Text('Site: Planet Earth', style: jediStyle),
                      ],
                    )
                  : Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Status: ', style: jediStyle),
                          TextSpan(
                              text: 'Error',
                              style: jediStyle.copyWith(color: Colors.red)),
                        ],
                      ),
                    ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    BlocProvider.of<ReportSightingBloc>(context)
                        .add(const ResetReportSightingEvent());
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 7),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text('accept',
                          style: jediStyle.copyWith(color: Colors.black))),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _cardAttribute(BuildContext context,
      {required String attribute, required String value}) {
    return Container(
      margin: const EdgeInsets.all(3),
      //padding: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Text("${attribute.toUpperCase()} ",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Text(
            value.toLowerCase(),
            style: const TextStyle(
                color: Colors.white,
                fontFamily: "starjhol",
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _cardVehiclesAttribute(BuildContext context,
      {required List<String> attributes, required String attribute}) {
    for (var i = 0; i < attributes.length; i++) {
      return Container(
        margin: const EdgeInsets.all(3),
        //padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Text("${attribute.toUpperCase()} ",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: attributes.length,
              itemBuilder: (context, index) {
                return Text(
                  attributes[index].toLowerCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "starjhol",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                );
              },
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
