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

  CareerData({
    required this.description,
    required this.uid,
  });

  factory CareerData.fromJson(Map<String, dynamic> json) => CareerData(
        description: json["description"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
      };
}
