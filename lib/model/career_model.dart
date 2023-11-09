// To parse this JSON data, do
//
//     final careerData = careerDataFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

CareerData careerDataFromJson(String str) =>
    CareerData.fromJson(json.decode(str));

String careerDataToJson(CareerData data) => json.encode(data.toJson());

class CareerData {
  String description;
  String uid;
  String id;

  CareerData({
    required this.description,
    required this.uid,
    required this.id,
  });

  factory CareerData.fromJson(Map<String, dynamic> json) => CareerData(
        description: json["description"],
        id: json["id"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() =>
      {"description": description, "uid": uid, "id": id};
}
