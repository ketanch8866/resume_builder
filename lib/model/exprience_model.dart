// To parse this JSON data, do
//
//     final experienceData = experienceDataFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

// ExperienceData experienceDataFromJson(String str) =>
//     ExperienceData.fromJson(json.decode(str));

// String experienceDataToJson(ExperienceData data) => json.encode(data.toJson());


Experience experienceFromJson(String str) => Experience.fromJson(json.decode(str));

String experienceToJson(Experience data) => json.encode(data.toJson());

class Experience {
    String id;
    String uid;
    List<ExperienceData> data;

    Experience({
        required this.id,
        required this.uid,
        required this.data,
    });

    factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["id"],
        uid: json["uid"],
        data: List<ExperienceData>.from(json["data"].map((x) => ExperienceData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}
class ExperienceData {
  String companyName;
  TextEditingController companyNameController;
  // String uid;
  // String id;
  String roll;
  TextEditingController rollController;
  DateTime startTime;
  DateTime endTime;
  String decription;
  TextEditingController decriptionController;

  ExperienceData(
      {required this.companyName,
      // required this.uid,
      // required this.id,
      required this.roll,
      required this.startTime,
      required this.endTime,
      required this.decription,
      required this.companyNameController,
      required this.decriptionController,
      required this.rollController});

  factory ExperienceData.fromJson(Map<String, dynamic> json) => ExperienceData(
      companyName: json["company_name"],
      // id: json["id"],
      // uid: json["uid"],
      roll: json["roll"],
      startTime: DateTime.parse(json["start_time"]),
      endTime: DateTime.parse(json["end_time"]),
      decription: json["decription"],
      companyNameController: TextEditingController(text: json["company_name"]),
      decriptionController: TextEditingController(text: json["decription"]),
      rollController: TextEditingController(text: json["roll"]));

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "roll": roll,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "decription": decription,
        // "uid": uid,
        // "id": id
      };
}
