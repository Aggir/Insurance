class BranchModel {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? lat;
  final String? lng;
  final int? companyId;

  BranchModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.lat,
    this.lng,
    this.companyId,
  });

  factory BranchModel.fromMap(Map<String, dynamic> map) {
    return BranchModel(
      id: map['id']?.toInt(),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      name: map['name'],
      lat: map['lat'],
      lng: map['lng'],
      companyId: map['companyId']?.toInt(),
    );
  }

  @override
  String toString() {
    return 'BranchModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, lat: $lat, lng: $lng, companyId: $companyId)';
  }
}
