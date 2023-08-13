import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/enums/gender.dart';

class UserEntity extends Equatable {
  final int id;
  final String firstName;
  final String fatherName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final Gender gender;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.fatherName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        fatherName,
        lastName,
        email,
        phone,
        dateOfBirth,
        gender,
      ];

  @override
  String toString() {
    return 'UserEntity(id: $id, firstName: $firstName, fatherName: $fatherName, lastName: $lastName, email: $email, phone: $phone, dateOfBirth: $dateOfBirth, gender: $gender)';
  }
}
