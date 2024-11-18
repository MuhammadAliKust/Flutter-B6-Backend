// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final String? userID;
  final String? imageUrl;
  final String? imageName;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.isCompleted,
    this.imageUrl,
    this.imageName,
    this.userID,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        docId: json["docID"],
        title: json["title"],
        description: json["description"],
        isCompleted: json["isCompleted"],
        imageName: json["imageName"],
        imageUrl: json["imageUrl"],
        userID: json["userID"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson(String taskID) => {
        "docID": taskID,
        "title": title,
        "description": description,
        "isCompleted": isCompleted,
        "userID": userID,
        "imageUrl": imageUrl,
        "imageName": imageName,
        "createdAt": createdAt,
      };
}
