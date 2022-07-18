import 'package:challenge_flutter_2022/constants/constants.dart';
import 'package:challenge_flutter_2022/screens/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  final String background;
  final String topText;
  final String bottomText;
  final String lottie;

  const Loading(
      {super.key,
      required this.background,
      required this.topText,
      required this.bottomText,
      required this.lottie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(image: background),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  topText,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                Lottie.asset('assets/lotties/$lottie.json',
                    height: MediaQuery.of(context).size.height * 0.3),
                Text(
                  bottomText,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
