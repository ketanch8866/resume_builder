// To parse this JSON data, do
//
//     final profileData = profileDataFromJson(jsonString);

import 'dart:convert';

ProfileData profileDataFromJson(String str) => ProfileData.fromJson(json.decode(str));

String profileDataToJson(ProfileData data) => json.encode(data.toJson());

class ProfileData {
  final String name;
  final String email;
  final String mobile;
  final String linkedInUrl;
  final String city;

  ProfileData({
    required this.name,
    required this.email,
    required this.mobile,
    required this.linkedInUrl,
    required this.city,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    linkedInUrl: json["linkedIn_url"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "mobile": mobile,
    "linkedIn_url": linkedInUrl,
    "city": city,
  };
}
