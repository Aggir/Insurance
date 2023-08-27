import 'dart:convert';

class VehicleModelModel {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final int vehicleBrandId;

  VehicleModelModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.vehicleBrandId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'name': name,
      'vehicle_brand_id': vehicleBrandId,
    };
  }

  factory VehicleModelModel.fromMap(Map<String, dynamic> map) {
    return VehicleModelModel(
      id: map['id']?.toInt() ?? 0,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
      name: map['name'] ?? '',
      vehicleBrandId: map['vehicle_brand_id'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleModelModel.fromJson(String source) =>
      VehicleModelModel.fromMap(json.decode(source));
}
