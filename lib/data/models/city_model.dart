class CityModel {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? lat;
  final String? lng;

  CityModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'name': name,
      'lat': lat,
      'lng': lng,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id']?.toInt() ?? 0,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
      name: map['name'] ?? '',
      lat: map['lat'] ?? '',
      lng: map['lng'] ?? '',
    );
  }
}
