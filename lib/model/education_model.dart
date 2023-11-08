// To parse this JSON data, do
//
//     final educationData = educationDataFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

EducationData educationDataFromJson(String str) =>
    EducationData.fromJson(json.decode(str));

String educationDataToJson(EducationData data) => json.encode(data.toJson());

class EducationData {
  String univercityName;
  TextEditingController univercityController;
  String uid;
  String degree;
  TextEditingController degreeController;
  DateTime startTime;
  DateTime endTime;
  String grade;
  TextEditingController gradeController;

  EducationData({
    required this.univercityName,
    required this.uid,
    required this.degree,
    required this.startTime,
    required this.endTime,
    required this.grade,
    required this.degreeController,
    required this.gradeController,
    required this.univercityController,
  });

  factory EducationData.fromJson(Map<String, dynamic> json) => EducationData(
        univercityName: json["univercity_name"],
        uid: json["uid"],
        degree: json["degree"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        grade: json["grade"],
        degreeController: TextEditingController(text: json["degree"]),
        gradeController: TextEditingController(text: json["grade"]),
        univercityController:
            TextEditingController(text: json["univercity_name"]),
      );

  Map<String, dynamic> toJson() => {
        "univercity_name": univercityName,
        "uid": uid,
        "degree": degree,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "grade": grade,
      };
}
