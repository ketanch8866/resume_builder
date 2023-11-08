// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String displayName;
  final String uid;
  final String email;
  final DateTime cretedTime;

  UserModel({
    required this.displayName,
    required this.uid,
    required this.email,
    required this.cretedTime,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        displayName: json["display_name"],
        uid: json["uid"],
        email: json["email"],
        cretedTime: DateTime.parse(json["creted_time"]),
      );

  Map<String, dynamic> toJson() => {
        "display_name": displayName,
        "uid": uid,
        "email": email,
        "creted_time": cretedTime.toIso8601String(),
      };
}
