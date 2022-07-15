import 'dart:convert';

import 'package:challenge_flutter_2022/data/models/character_model.dart';
import 'package:http/http.dart' as http;

class CharacterRepository {
  Future<List<CharacterModel>> getCharacters(int page) async {
    List<CharacterModel> characters;
    try {
      var response = await http.get(
          Uri.parse('https://swapi.dev/api/people/?page=$page'),
          headers: {"Content-type": "application/json", 'charset': 'utf-8'});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        final results = data['results'] as List;
        characters = results
            .map((characters) => CharacterModel.fromJson(characters))
            .toList();
        return characters;
      } else if (response.statusCode == 404) {
        //ver bien el 404
        return [];
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return [];
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
