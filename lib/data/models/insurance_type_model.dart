class InsuranceTypeModel {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  InsuranceTypeModel(
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory InsuranceTypeModel.fromMap(Map<String, dynamic> map) {
    return InsuranceTypeModel(
      map['id']?.toInt(),
      map['name'],
      map['createdAt'],
      map['updatedAt'],
    );
  }
}
