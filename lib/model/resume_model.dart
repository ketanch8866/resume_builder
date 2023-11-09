// To parse this JSON data, do
//
//     final resume = resumeFromJson(jsonString);

import 'dart:convert';

Resume resumeFromJson(String str) => Resume.fromJson(json.decode(str));

String resumeToJson(Resume data) => json.encode(data.toJson());

class Resume {
  final String id;
  final String uid;
  final String name;

  Resume({
    required this.id,
    required this.uid,
    required this.name,
  });

  factory Resume.fromJson(Map<String, dynamic> json) => Resume(
        id: json["id"],
        uid: json["uid"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "name": name,
      };
}
