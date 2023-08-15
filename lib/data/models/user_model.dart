import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? id;
  final String? firstName;
  final String? fatherName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? photo;
  final DateTime? dateOfBirth;
  final String? gender;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isActive;

  const UserModel({
    this.id,
    this.firstName,
    this.fatherName,
    this.lastName,
    this.email,
    this.phone,
    this.photo,
    this.dateOfBirth,
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        fatherName,
        lastName,
        email,
        phone,
        photo,
        dateOfBirth,
        gender,
        createdAt,
        updatedAt,
        isActive,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'father_name': fatherName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'dob': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'is_active': isActive,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt(),
      firstName: map['first_name'],
      fatherName: map['father_name'],
      lastName: map['last_name'],
      email: map['email'],
      phone: map['phone'],
      dateOfBirth: map['dob'] != null ? DateTime.parse(map['dob']) : null,
      gender: map['gender'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      isActive: map['is_active'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
