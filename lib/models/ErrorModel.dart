
import 'dart:convert';

class ErrorModel {
  final String message;
  final String exception;

  ErrorModel({
    required this.message,
    required this.exception,
  });

  ErrorModel copyWith({
    String? message,
    String? exception,
  }) =>
      ErrorModel(
        message: message ?? this.message,
        exception: exception ?? this.exception,
      );

  factory ErrorModel.fromRawJson(String str) => ErrorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    message: json["message"],
    exception: json["exception"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "exception": exception,
  };
}
