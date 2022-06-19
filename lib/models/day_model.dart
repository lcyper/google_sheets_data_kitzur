// To parse this JSON data, do
//
//     final libraryStatics = libraryStaticsFromMap(jsonString);

import 'dart:convert';

class Day {
  Day({
    required this.date,
    required this.message,
    required this.completedDate,
  });

  final String date;
  final String message;
  final String completedDate;

  factory Day.fromJson(String str) => Day.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  factory Day.fromMap(Map<String, dynamic> json) => Day(
        date: json["fecha"] ?? '',
        message: json["mensaje"] ?? '',
        completedDate: json["fecha completa"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "fecha": date,
        "mensaje": message,
        "fecha completa": completedDate,
      };
}
