// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.data,
  });

  List<Role>? data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        data: json["data"] == null
            ? null
            : List<Role>.from(json["data"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Role {
  Role({
    this.id,
    this.title,
    this.statement,
    this.image,
    this.slug,
  });

  String? id;
  String? title;
  String? statement;
  String? image;
  String? slug;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        statement: json["statement"] == null ? null : json["statement"],
        image: json["image"] == null ? null : json["image"],
        slug: json["slug"] == null ? null : json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "statement": statement,
        "image": image,
        "slug": slug,
      };
}
