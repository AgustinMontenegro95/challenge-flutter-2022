import 'package:challenge_flutter_2022/bloc/character/character_bloc.dart';
import 'package:challenge_flutter_2022/data/repository/character_respository.dart';
import 'package:challenge_flutter_2022/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CharacterBloc(CharacterRepository())
            ..add(const LoadCharacterEvent(1)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Challenge Flutter 2022',
        initialRoute: '/',
        routes: customRoutes,
      ),
    );
  }
}
