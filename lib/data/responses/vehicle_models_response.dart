import 'dart:convert';

import 'package:insurance_app/data/models/vehicle_model_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class VehicleModelsResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  final List<VehicleModelModel>? vehicleModels;

  VehicleModelsResponse({
    this.code,
    this.message,
    this.vehicleModels,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'vehicleModels': vehicleModels?.map((x) => x.toMap()).toList(),
    };
  }

  factory VehicleModelsResponse.fromMap(Map<String, dynamic> map) {
    return VehicleModelsResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      vehicleModels: map['vehicleModels'] != null
          ? List<VehicleModelModel>.from(
              map['vehicleModels']?.map((x) => VehicleModelModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleModelsResponse.fromJson(String source) =>
      VehicleModelsResponse.fromMap(json.decode(source));
}
