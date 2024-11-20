// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? docId;
  final String? email;
  final String? phone;
  final String? name;
  final int? createdAt;

  UserModel({
    this.docId,
    this.email,
    this.phone,
    this.name,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        docId: json["docID"],
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "docID": docId,
        "email": email,
        "phone": phone,
        "name": name,
        "createdAt": Timestamp.now().millisecondsSinceEpoch,
      };
}
