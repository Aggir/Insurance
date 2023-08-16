import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/enums/gender.dart';

class UserEntity extends Equatable {
  final int userId;
  final String firstName;
  final String fatherName;
  final String lastName;
  final String email;
  final String phone;
  final String imageUrl;
  final bool isLibyan;
  final String dateOfBirth;
  final Gender gender;
  final String updatedAt;

  const UserEntity({
    required this.userId,
    required this.firstName,
    required this.fatherName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.isLibyan,
    required this.dateOfBirth,
    required this.gender,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        userId,
        firstName,
        fatherName,
        lastName,
        email,
        phone,
        imageUrl,
        isLibyan,
        dateOfBirth,
        gender,
        updatedAt,
      ];

  @override
  String toString() {
    return 'UserEntity(userId: $userId, firstName: $firstName, fatherName: $fatherName, lastName: $lastName, email: $email, phone: $phone, imageUrl: $imageUrl, dateOfBirth: $dateOfBirth, gender: $gender)';
  }
}
