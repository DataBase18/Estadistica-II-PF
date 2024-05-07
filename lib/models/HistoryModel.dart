

import 'dart:convert';

class HistoryModel {
  final String? typeDesc;
  final String? value;
  final DateTime? date;

  HistoryModel({
    this.typeDesc,
    this.value,
    this.date,
  });

  HistoryModel copyWith({
    String? typeDesc,
    String? value,
    DateTime? date,
  }) =>
      HistoryModel(
        typeDesc: typeDesc ?? this.typeDesc,
        value: value ?? this.value,
        date: date ?? this.date,
      );

  factory HistoryModel.fromRawJson(String str) => HistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    typeDesc: json["type_desc"],
    value: json["value"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "type_desc": typeDesc,
    "value": value,
    "date": date?.toIso8601String(),
  };
}
