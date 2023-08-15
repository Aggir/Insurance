import 'dart:convert';

import 'package:insurance_app/data/models/vehicle_ownership_type_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class VehicleOwnershipTypesResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  final List<VehicleOwnershipTypeModel>? vehicleOwnershipTypes;

  VehicleOwnershipTypesResponse({
    this.code,
    this.message,
    this.vehicleOwnershipTypes,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'vehicleOwnershipTypes':
          vehicleOwnershipTypes?.map((x) => x.toMap()).toList(),
    };
  }

  factory VehicleOwnershipTypesResponse.fromMap(Map<String, dynamic> map) {
    return VehicleOwnershipTypesResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      vehicleOwnershipTypes: map['vehicleOwnershipTypes'] != null
          ? List<VehicleOwnershipTypeModel>.from(map['vehicleOwnershipTypes']
              ?.map((x) => VehicleOwnershipTypeModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleOwnershipTypesResponse.fromJson(String source) =>
      VehicleOwnershipTypesResponse.fromMap(json.decode(source));
}
