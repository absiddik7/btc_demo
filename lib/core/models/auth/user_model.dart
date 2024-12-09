// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    Data data;
    String message;
    dynamic meta;
    dynamic errors;
    String status;

    UserModel({
        required this.data,
        required this.message,
        required this.meta,
        required this.errors,
        required this.status,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        meta: json["meta"],
        errors: json["errors"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "meta": meta,
        "errors": errors,
        "status": status,
    };
}

class Data {
    int id;
    String firstName;
    String lastName;
    String email;
    bool isEmailVerified;
    String firebaseUserId;

    Data({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.isEmailVerified,
        required this.firebaseUserId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        isEmailVerified: json["isEmailVerified"],
        firebaseUserId: json["firebaseUserId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "isEmailVerified": isEmailVerified,
        "firebaseUserId": firebaseUserId,
    };
}
