import 'package:challenge_flutter_2022/screens/attributes/attributes_screen.dart';
import 'package:challenge_flutter_2022/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:challenge_flutter_2022/screens/home/home_screen.dart';

var customRoutes = <String, WidgetBuilder>{
  '/': (context) => const HomeScreen(),
  '/attributes': (context) => const AttributesScreen(),
  '/settings': (context) => const SettingsScreen(),
};
