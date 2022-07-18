import 'dart:convert';
import 'package:challenge_flutter_2022/data/models/character_model.dart';
import 'package:http/http.dart' as http;

class AttributesRepository {
  Future<List<String>> getVehiclesAttributes(CharacterModel character) async {
    List<String> vehicles = [];
    for (var i = 0; i < character.vehicles.length; i++) {
      var response = await http.get(Uri.parse(character.vehicles[i]));
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      vehicles.add(data['name']);
    }
    return vehicles;
  }

  Future<List<String>> getStarshipsAttributes(CharacterModel character) async {
    List<String> starships = [];
    for (var i = 0; i < character.starships.length; i++) {
      var response = await http.get(Uri.parse(character.starships[i]));
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      starships.add(data['name']);
    }
    return starships;
  }

  Future<List<String>> getHomeworldAttributes(CharacterModel character) async {
    List<String> homeworld = [];
    var response = await http.get(Uri.parse(character.homeworld));
    Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    homeworld.add(data['name']);
    return homeworld;
  }
}
