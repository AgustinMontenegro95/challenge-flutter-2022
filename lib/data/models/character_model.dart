class CharacterModel {
  String name;
  String height;
  String mass;
  String hairColor;
  String skinColor;
  String eyeColor;
  String birthYear;
  String gender;
  String homeworld;
  List<String> vehicles;
  List<String> starships;

  CharacterModel({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.homeworld,
    required this.vehicles,
    required this.starships,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json["name"],
      height: json["height"],
      mass: json["mass"],
      hairColor: json["hair_color"],
      skinColor: json["skin_color"],
      eyeColor: json["eye_color"],
      birthYear: json["birth_year"],
      gender: json["gender"],
      homeworld: json["homeworld"],
      vehicles: List<String>.from(json["vehicles"].map((x) => x)),
      starships: List<String>.from(json["starships"].map((x) => x)),
    );
  }
}
