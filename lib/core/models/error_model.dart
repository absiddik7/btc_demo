// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
    String message;
    dynamic errors;
    String status;

    ErrorModel({
        required this.message,
        required this.errors,
        required this.status,
    });

    factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json["message"],
        errors: json["errors"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors,
        "status": status,
    };
}
