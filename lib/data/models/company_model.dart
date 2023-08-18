class CompanyModel {
  final int? id;
  final String? name;
  final String? description;
  final String? photo;
  final String? createdAt;
  final String? updatedAt;
  final int? priority;

  CompanyModel({
    this.id,
    this.name,
    this.description,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'priority': priority,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id']?.toInt(),
      name: map['name'],
      description: map['description'],
      photo: map['photo'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      priority: map['priority']?.toInt(),
    );
  }
}
