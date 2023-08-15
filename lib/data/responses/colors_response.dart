import 'dart:convert';

import 'package:insurance_app/data/models/color_model.dart';

import 'base_response.dart';

class ColorsResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  final List<ColorModel>? colors;

  ColorsResponse({
    this.code,
    this.message,
    this.colors,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'colors': colors?.map((x) => x.toMap()).toList(),
    };
  }

  factory ColorsResponse.fromMap(Map<String, dynamic> map) {
    return ColorsResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      colors: map['colors'] != null
          ? List<ColorModel>.from(
              map['colors']?.map((x) => ColorModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorsResponse.fromJson(String source) =>
      ColorsResponse.fromMap(json.decode(source));
}
