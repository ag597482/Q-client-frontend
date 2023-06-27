class Entity {
  String? name;
  String? phoneNo;
  String? password;
  bool? isLoggedIn;

  Entity();

  Entity.init({this.name, this.phoneNo, this.password, this.isLoggedIn});

  Entity.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        phoneNo = json['phoneNo'] as String,
        password = json['password'] as String,
        isLoggedIn = json['isLoggedIn'] as bool;

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNo': phoneNo,
        'password': password,
        'isLoggedIn': isLoggedIn,
      };
}
