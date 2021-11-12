import 'package:firebase_database/firebase_database.dart';

class User {
  final String email;
  final String password;
  User(this.email, this.password);

  Map<String, dynamic> toJson() =>
    {"email": email, "password": password};


  User.fromJson(Map<String,String> json)
  : email = json['email']!,
    password = json['password']!;


  @override
  String toString() {
    return "{email: $email  ---- password: $password\n}";
  }
}
