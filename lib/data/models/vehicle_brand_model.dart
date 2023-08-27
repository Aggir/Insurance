import 'dart:convert';

class VehicleBrandModel {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String icon;

  VehicleBrandModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'name': name,
      'icon': icon,
    };
  }

  factory VehicleBrandModel.fromMap(Map<String, dynamic> map) {
    return VehicleBrandModel(
      id: map['id']?.toInt() ?? 0,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
      name: map['name'] ?? '',
      icon: map['icon'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleBrandModel.fromJson(String source) =>
      VehicleBrandModel.fromMap(json.decode(source));
}
