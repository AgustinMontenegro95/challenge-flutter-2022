import 'package:challenge_flutter_2022/bloc/attributes/attributes_bloc.dart';
import 'package:challenge_flutter_2022/bloc/character/character_bloc.dart';
import 'package:challenge_flutter_2022/constants/constants.dart';
import 'package:challenge_flutter_2022/data/models/character_model.dart';
import 'package:challenge_flutter_2022/screens/widgets/app_bar.dart';
import 'package:challenge_flutter_2022/screens/widgets/background.dart';
import 'package:challenge_flutter_2022/screens/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoadingState) {
          return const Loading(
            background: 'background-home.png',
            topText: 'Loading characters',
            bottomText: 'Wait a moment',
            lottie: 'loading-red',
          );
        }
        if (state is CharacterLoadedState) {
          FlutterNativeSplash.remove();
          List<CharacterModel> characters = state.character;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: appBar(context, settings: true),
            body: Stack(
              children: [
                const Background(
                  image: 'background-home.png',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.93,
                  child: ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (context, i) {
                      return _character(characters, i);
                    },
                  ),
                ),
                Column(
                  children: [
                    Expanded(child: Container()),
                    _pages(context),
                  ],
                ),
              ],
            ),
          );
        }
        if (state is CharacterErrorState) {
          return Center(
            child: Text(state.error.toString()),
          );
        }
        return Container();
      },
    );
  }

  Widget _character(List<CharacterModel> characters, int i) {
    return GestureDetector(
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              characters[i].name.toLowerCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "starjhol",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: fontColor),
            ),
            Text(
              characters[i].gender.toUpperCase(),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 5,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        BlocProvider.of<AttributesBloc>(context)
            .add(LoadAttributesEvent(character: characters[i]));
        Navigator.pushNamed(context, '/attributes', arguments: characters[i]);
      },
    );
  }

  Widget _pages(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: page == 1
              ? null
              : () {
                  BlocProvider.of<CharacterBloc>(context)
                      .add(LoadCharacterEvent(page = page - 1));
                },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: fontColor,
            size: 30,
          ),
        ),
        Row(
          children: [
            _buttonPage(context, 1),
            _buttonPage(context, 2),
            _buttonPage(context, 3),
            _buttonPage(context, 4),
            _buttonPage(context, 5),
            _buttonPage(context, 6),
            _buttonPage(context, 7),
            _buttonPage(context, 8),
            _buttonPage(context, 9),
          ],
        ),
        IconButton(
          onPressed: page == 9
              ? null
              : () {
                  BlocProvider.of<CharacterBloc>(context)
                      .add(LoadCharacterEvent(page = page + 1));
                },
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: fontColor,
            size: 30,
          ),
        ),
      ],
    );
  }

  Widget _buttonPage(BuildContext context, int buttonPage) {
    return GestureDetector(
      onTap: () {
        page = buttonPage;
        BlocProvider.of<CharacterBloc>(context).add(LoadCharacterEvent(page));
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Text(
          buttonPage.toString(),
          style: TextStyle(
              fontSize: page == buttonPage ? 30 : 20,
              color: fontColor,
              fontFamily: page == buttonPage ? 'starjedi' : 'starjhol',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
