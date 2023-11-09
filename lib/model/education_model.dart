// To parse this JSON data, do
//
//     final educationData = educationDataFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

// EducationData educationDataFromJson(String str) =>
//     EducationData.fromJson(json.decode(str));

// String educationDataToJson(EducationData data) => json.encode(data.toJson());
Education educationFromJson(String str) => Education.fromJson(json.decode(str));

String educationToJson(Education data) => json.encode(data.toJson());

class Education {
  String id;
  String uid;
  List<EducationData> data;

  Education({
    required this.id,
    required this.uid,
    required this.data,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["id"],
        uid: json["uid"],
        data: List<EducationData>.from(
            json["data"].map((x) => EducationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EducationData {
  String univercityName;
  TextEditingController univercityController;
  // String uid;
  // String id;
  String degree;
  TextEditingController degreeController;
  DateTime startTime;
  DateTime endTime;
  String grade;
  TextEditingController gradeController;

  EducationData({
    required this.univercityName,
    // required this.uid,
    // required this.id,
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
        // id: json["id"],
        // uid: json["uid"],
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
        // "uid": uid,
        // "id": id,
        "degree": degree,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "grade": grade,
      };
}
