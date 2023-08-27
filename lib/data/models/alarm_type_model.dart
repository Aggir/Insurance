class AlarmTypeModel {
  final String? name;
  final String? createdAt;
  final String? updatedAt;
  final int? id;
  AlarmTypeModel({
    this.name,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'id': id,
    };
  }

  factory AlarmTypeModel.fromMap(Map<String, dynamic> map) {
    return AlarmTypeModel(
      name: map['name'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      id: map['id']?.toInt(),
    );
  }
}
