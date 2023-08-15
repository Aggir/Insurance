import 'dart:convert';

import 'package:insurance_app/data/models/city_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class CitiesResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  final List<CityModel>? cities;

  CitiesResponse({
    this.code,
    this.message,
    this.cities,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'cities': cities?.map((x) => x.toMap()).toList(),
    };
  }

  factory CitiesResponse.fromMap(Map<String, dynamic> map) {
    return CitiesResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      cities: map['cities'] != null
          ? List<CityModel>.from(
              map['cities']?.map((x) => CityModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CitiesResponse.fromJson(String source) =>
      CitiesResponse.fromMap(json.decode(source));
}
