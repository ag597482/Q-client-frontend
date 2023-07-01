class Entity {
  String? id;
  String? name;
  int? phoneNumber;
  String? password;
  bool? isLoggedIn;

  Entity();

  Entity.init({this.name, this.phoneNumber, this.password, this.isLoggedIn});

  Entity.fromJson(Map<String, dynamic> json)
      : id = (json['id'] ?? "Na") as String,
        name = (json['name'] ?? "Na") as String,
        phoneNumber = (json['phoneNumber'] ?? 0) as int,
        password = (json['password'] ?? "Na") as String,
        isLoggedIn = (json['isLoggedIn'] ?? true) as bool;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phoneNumber': phoneNumber,
        'password': password,
        'isLoggedIn': isLoggedIn,
      };
}
