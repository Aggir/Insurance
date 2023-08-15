import 'dart:convert';

import 'package:insurance_app/data/models/vehicle_brand_model.dart';

import 'base_response.dart';

class VehicleBrandsResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  final List<VehicleBrandModel>? vehicleBrands;

  VehicleBrandsResponse({
    this.code,
    this.message,
    this.vehicleBrands,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'vehicleBrands': vehicleBrands?.map((x) => x.toMap()).toList(),
    };
  }

  factory VehicleBrandsResponse.fromMap(Map<String, dynamic> map) {
    return VehicleBrandsResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      vehicleBrands: map['vehicleBrands'] != null
          ? List<VehicleBrandModel>.from(
              map['vehicleBrands']?.map((x) => VehicleBrandModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleBrandsResponse.fromJson(String source) =>
      VehicleBrandsResponse.fromMap(json.decode(source));
}
