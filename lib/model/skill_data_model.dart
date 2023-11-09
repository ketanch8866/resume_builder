// To parse this JSON data, do
//
//     final skill = skillFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Skill skillFromJson(String str) => Skill.fromJson(json.decode(str));

String skillToJson(Skill data) => json.encode(data.toJson());

class Skill {
  String skill;
  //  String uid;
  //  String id;
  Rx<TextEditingController> controller;

  Skill({
    required this.skill,
    // required this.id,
    // required this.uid,
    required this.controller,
  });

  factory Skill.fromJson(String skills) => Skill(
        skill: skills,
        //  id: json["id"],
        // uid: json["uid"],
        controller: TextEditingController(text: skills).obs,
      );

  Map<String, dynamic> toJson() => {
        "skill": skill,
        // "uid":uid,
        // "id":id
      };
}
