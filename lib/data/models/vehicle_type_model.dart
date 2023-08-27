import 'dart:convert';

class VehicleTypeModel {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;

  VehicleTypeModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'name': name,
    };
  }

  factory VehicleTypeModel.fromMap(Map<String, dynamic> map) {
    return VehicleTypeModel(
      id: map['id']?.toInt() ?? 0,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleTypeModel.fromJson(String source) =>
      VehicleTypeModel.fromMap(json.decode(source));
}
