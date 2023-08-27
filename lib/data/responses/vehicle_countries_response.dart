import 'dart:convert';

import 'package:insurance_app/data/models/vehicle_country_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class VehicleCountriesResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  final List<VehicleCountryModel>? vehicleCountries;

  VehicleCountriesResponse({
    this.code,
    this.message,
    this.vehicleCountries,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'vehicleCountries': vehicleCountries?.map((x) => x.toMap()).toList(),
    };
  }

  factory VehicleCountriesResponse.fromMap(Map<String, dynamic> map) {
    return VehicleCountriesResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      vehicleCountries: map['vehicleCountries'] != null
          ? List<VehicleCountryModel>.from(map['vehicleCountries']
              ?.map((x) => VehicleCountryModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleCountriesResponse.fromJson(String source) =>
      VehicleCountriesResponse.fromMap(json.decode(source));
}
