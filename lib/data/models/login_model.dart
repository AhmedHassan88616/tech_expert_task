// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));


class LoginModel {
  LoginModel({
    this.userRole,
    this.isActive,
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.error,
  });

  String? userRole;
  String? isActive;
  String? accessToken;
  String? tokenType;
  dynamic expiresIn;
  String? error;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    userRole: json["userRole"],
    isActive: json["isActive"],
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    error: json["error"],
  );

}
