class Entity {
  String? id;
  String? name;
  String? phoneNumber;
  String? password;
  bool? isLoggedIn;

  Entity();

  Entity.init({this.name, this.phoneNumber, this.password, this.isLoggedIn});

  Entity.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? "Na" as String,
        phoneNumber = json['phoneNumber'] ?? "Ph" as String,
        password = json['password'] ?? "Pa" as String,
        isLoggedIn = json['isLoggedIn'] ?? true as bool;

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'password': password,
        'isLoggedIn': isLoggedIn,
      };
}
