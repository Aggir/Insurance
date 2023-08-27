import 'dart:convert';

import 'package:insurance_app/data/models/user_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class UserResponse implements BaseResponse {
  final UserModel? user;
  final String? token;

  @override
  String? message;

  @override
  int? code;

  UserResponse({
    this.user,
    this.token,
    this.message,
    this.code,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user?.toMap(),
      'token': token,
      'message': message,
      'code': code,
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      user: map['user'] != null ? UserModel.fromMap(map['user']) : null,
      token: map['token'],
      message: map['message'],
      code: map['code']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) =>
      UserResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserResponse(user: $user, token: $token, message: $message, code: $code)';
  }
}
