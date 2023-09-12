import 'package:equatable/equatable.dart';
import 'package:insurance_app/app/constants.dart';

import 'package:insurance_app/app/enums/gender.dart';

class UserEntity extends Equatable {
  final int userId;
  final String uniqueId;
  final String firstName;
  final String fatherName;
  final String lastName;
  final String email;
  final String phone;
  final String phoneCode;
  final String imageUrl;
  final bool isLibyan;
  final String dateOfBirth;
  final Gender gender;
  final String updatedAt;
  final String emailVerifiedAt;

  const UserEntity({
    required this.userId,
    required this.uniqueId,
    required this.firstName,
    required this.fatherName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.phoneCode,
    required this.imageUrl,
    required this.isLibyan,
    required this.dateOfBirth,
    required this.gender,
    required this.updatedAt,
    required this.emailVerifiedAt,
  });

  factory UserEntity.empty() => const UserEntity(
        userId: Constants.zero,
        uniqueId: Constants.empty,
        firstName: Constants.empty,
        fatherName: Constants.empty,
        lastName: Constants.empty,
        email: Constants.empty,
        phone: Constants.empty,
        phoneCode: Constants.empty,
        imageUrl: Constants.empty,
        dateOfBirth: Constants.empty,
        isLibyan: true,
        gender: Gender.male,
        updatedAt: Constants.empty,
        emailVerifiedAt: Constants.empty,
      );

  @override
  List<Object?> get props => [
        userId,
        uniqueId,
        firstName,
        fatherName,
        lastName,
        email,
        phone,
        phoneCode,
        imageUrl,
        isLibyan,
        dateOfBirth,
        gender,
        updatedAt,
        emailVerifiedAt,
      ];

  @override
  String toString() {
    return 'UserEntity(userId: $userId, firstName: $firstName, fatherName: $fatherName, lastName: $lastName, email: $email, phone: $phone, imageUrl: $imageUrl, dateOfBirth: $dateOfBirth, gender: $gender)';
  }
}
