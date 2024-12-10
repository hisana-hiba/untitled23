// To parse this JSON data, do
//
//     final dio = dioFromJson(jsonString);

import 'dart:convert';

List<Dio> dioFromJson(String str) => List<Dio>.from(json.decode(str).map((x) => Dio.fromJson(x)));

String dioToJson(List<Dio> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dio {
  int userId;
  int id;
  String title;
  String body;

  Dio({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Dio.fromJson(Map<String, dynamic> json) => Dio(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
