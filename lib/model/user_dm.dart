class UserDM {
  static const collectionName = "users";
  late String id;
  late String email;
  late String name;
  late List<String> favorites;
  late String languageCode = 'en';

  UserDM({
    required this.email,
    required this.name,
    required this.id,
    this.languageCode = 'en',
    this.favorites = const [],
  });

  UserDM.fromJson(Map json) {
    email = json["email"];
    name = json["name"];
    id = json["id"];
    List<dynamic> favoritesJson = json["favorites"];
    favorites = favoritesJson.map((fav) => fav.toString()).toList();
    languageCode = json["language"];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "favorites": favorites,
    "language": languageCode,
  };
}
