import 'package:equatable/equatable.dart';

import 'package:insurance_app/app/enums/gender.dart';

class SignUpUserInfo extends Equatable {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String phoneCode;
  final String birthDate;
  final Gender gender;
  const SignUpUserInfo({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.phoneCode,
    required this.birthDate,
    required this.gender,
  });

  SignUpUserInfo copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? phoneCode,
    String? birthDate,
    Gender? gender,
  }) {
    return SignUpUserInfo(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneCode: phoneCode ?? this.phoneCode,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        email,
        phoneNumber,
        phoneCode,
        birthDate,
        gender,
      ];

  @override
  String toString() {
    return 'SignUpUserInfo(firstName: $firstName, middleName: $middleName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, birthDate: $birthDate, gender: $gender)';
  }
}
