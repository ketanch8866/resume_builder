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
   Rx<TextEditingController> controller;

  Skill({
    required this.skill,
    required this.controller,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    skill: json["skill"],
    controller:TextEditingController(text:  json["skill"]).obs,
  );

  Map<String, dynamic> toJson() => {
    "skill": skill,
  };
}
