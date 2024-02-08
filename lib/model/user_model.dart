import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? userId;
  String name;
  String email;
  String password;
  String? fcm;


  UserModel({
    this.id,
    this.userId,
    required this.name,
    required this.email,
    required this.password,
    this.fcm,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    fcm: json["fcm"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "email": email,
    "password": password,
    "fcm": fcm,
  };
  factory UserModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String , dynamic>> json) => UserModel(
      name: json["name"],
      email: json["email"],
      password: json ["password"],
      userId: json["user_id"],
      fcm: json["fcm"],


  );

}
