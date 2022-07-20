import 'package:challenge_flutter_2022/bloc/attributes/attributes_bloc.dart';
import 'package:challenge_flutter_2022/bloc/character/character_bloc.dart';
import 'package:challenge_flutter_2022/bloc/connection_switch/connection_switch_bloc.dart';
import 'package:challenge_flutter_2022/bloc/report_sighting/report_sighting_bloc.dart';
import 'package:challenge_flutter_2022/data/hive/switch_status.dart';
import 'package:challenge_flutter_2022/data/repository/character_respository.dart';
import 'package:challenge_flutter_2022/data/repository/attributes_repository.dart';
import 'package:challenge_flutter_2022/data/repository/report_sighting_repository.dart';
import 'package:challenge_flutter_2022/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  //initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(SwitchStatusAdapter());
  await Hive.openBox<SwitchStatus>('status');
  //
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(
      const MyApp(),
    ),
    storage: storage,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box<SwitchStatus> switchStatusBox;

  @override
  void initState() {
    super.initState();
    // Hive
    switchStatusBox = Hive.box('status');
    //
  }

  @override
  Widget build(BuildContext context) {
    //Hive
    bool status = switchStatusBox.get(0) == null
        ? false
        : switchStatusBox.get(0)!.status == false
            ? false
            : true;
    //
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CharacterBloc(CharacterRepository())
            ..add(const LoadCharacterEvent(1)),
        ),
        BlocProvider(
          create: (context) => AttributesBloc(AttributesRepository()),
        ),
        BlocProvider(
          create: (context) => ReportSightingBloc(ReportSightingRepository()),
        ),
        BlocProvider(
          create: (context) => ConnectionSwitchBloc()
            ..add(LoadConnectionEvent(statusSwitch: status)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Challenge Flutter 2022',
        initialRoute: '/',
        routes: customRoutes,
        theme: ThemeData(primarySwatch: Colors.blueGrey),
      ),
    );
  }
}
