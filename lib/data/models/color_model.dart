import 'dart:convert';

class ColorModel {
  final int id;
  final String hex;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;

  ColorModel({
    required this.id,
    required this.hex,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hex': hex,
      'created_at': createdAt.toIso8601String,
      'updated_at': updatedAt.toIso8601String,
      'name': name,
    };
  }

  factory ColorModel.fromMap(Map<String, dynamic> map) {
    return ColorModel(
      id: map['id']?.toInt() ?? 0,
      hex: map['hex'] ?? '',
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

  factory ColorModel.fromJson(String source) =>
      ColorModel.fromMap(json.decode(source));
}
