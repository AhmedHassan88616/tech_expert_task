// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

class RegisterModel {
  RegisterModel({
    required this.success,
    required this.error,
  });

  String success;
  Error? error;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        success: json["success"],
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error == null ? null : error!.toJson(),
      };
}

class Error {
  Error({
    this.name,
    this.email,
    this.password,
    this.role,
  });

  List<String>? name;
  List<String>? email;
  List<String>? password;
  List<String>? role;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        name: json["name"] == null
            ? null
            : List<String>.from(json["name"].map((x) => x)),
        email: json["email"] == null
            ? null
            : List<String>.from(json["email"].map((x) => x)),
        password: json["password"] == null
            ? null
            : List<String>.from(json["password"].map((x) => x)),
        role: json["role"] == null
            ? null
            : List<String>.from(json["role"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : List<dynamic>.from(name!.map((x) => x)),
        "email":
            email == null ? null : List<dynamic>.from(email!.map((x) => x)),
        "password": password == null
            ? null
            : List<dynamic>.from(password!.map((x) => x)),
        "role": role == null ? null : List<dynamic>.from(role!.map((x) => x)),
      };
}
