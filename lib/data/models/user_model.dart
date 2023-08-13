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
      'firstName': firstName,
      'fatherName': fatherName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'dob': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isActive': isActive,
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
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      isActive: map['isActive'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
