import 'package:insurance_app/data/models/meta_model.dart';
import 'package:insurance_app/data/models/vehicle_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class VehiclesResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  List<VehicleModel>? vehicles;

  MetaModel? meta;

  VehiclesResponse({
    this.code,
    this.message,
    this.vehicles,
    this.meta,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'vehicles': vehicles?.map((x) => x.toMap()).toList(),
      'meta': meta?.toMap(),
    };
  }

  factory VehiclesResponse.fromMap(Map<String, dynamic> map) {
    return VehiclesResponse(
        code: map['code']?.toInt(),
        message: map['message'],
        vehicles: map['data'] != null
            ? List<VehicleModel>.from(
                map['data']?.map((x) => VehicleModel.fromMap(x)))
            : null,
        meta: map['meta'] != null ? MetaModel.fromMap(map['meta']) : null);
  }

  @override
  String toString() {
    return 'VehiclesResponse(code: $code, message: $message, vehicles: ${vehicles?.length}, meta: $meta)';
  }
}
