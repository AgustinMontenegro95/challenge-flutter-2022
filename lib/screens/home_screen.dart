import 'package:challenge_flutter_2022/bloc/character/character_bloc.dart';
import 'package:challenge_flutter_2022/data/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoadingState) {
          return Stack(
            children: const [
              //const BackgroundBlack(),
              Center(child: CircularProgressIndicator(color: Colors.red)),
            ],
          );
        }
        if (state is CharacterLoadedState) {
          List<CharacterModel> characters = state.character;
          return Scaffold(
            body: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: characters.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(characters[i].name),
                        subtitle: Text(characters[i].gender),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CharacterBloc>(context)
                                .add(LoadCharacterEvent(1));
                          },
                          child: Text("Previous")),
                      Text("Pagina 1"),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CharacterBloc>(context)
                                .add(LoadCharacterEvent(2));
                          },
                          child: Text("Next")),
                    ],
                  ),
                ],
              ),
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
}
