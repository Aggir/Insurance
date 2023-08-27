import 'dart:convert';

class VehicleOwnershipTypeModel {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;

  VehicleOwnershipTypeModel({
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

  factory VehicleOwnershipTypeModel.fromMap(Map<String, dynamic> map) {
    return VehicleOwnershipTypeModel(
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

  factory VehicleOwnershipTypeModel.fromJson(String source) =>
      VehicleOwnershipTypeModel.fromMap(json.decode(source));
}
