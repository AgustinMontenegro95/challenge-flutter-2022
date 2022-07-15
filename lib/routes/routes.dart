import 'package:flutter/material.dart';
import 'package:challenge_flutter_2022/screens/home_screen.dart';

var customRoutes = <String, WidgetBuilder>{
  //'/charts': (context) => ScreenCharts(),
  '/': (context) => const HomeScreen(),
};
