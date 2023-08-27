import 'dart:convert';

import 'package:insurance_app/data/models/vehicle_type_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class VehicleTypesResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  final List<VehicleTypeModel>? vehicleTypes;

  VehicleTypesResponse({
    this.code,
    this.message,
    this.vehicleTypes,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'vehicleTypes': vehicleTypes?.map((x) => x.toMap()).toList(),
    };
  }

  factory VehicleTypesResponse.fromMap(Map<String, dynamic> map) {
    return VehicleTypesResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      vehicleTypes: map['vehicleTypes'] != null
          ? List<VehicleTypeModel>.from(
              map['vehicleTypes']?.map((x) => VehicleTypeModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleTypesResponse.fromJson(String source) =>
      VehicleTypesResponse.fromMap(json.decode(source));
}
