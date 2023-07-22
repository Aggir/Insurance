import 'package:equatable/equatable.dart';

class SignUpUserInfo extends Equatable {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String birthDate;
  const SignUpUserInfo({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
  });

  SignUpUserInfo copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? birthDate,
  }) {
    return SignUpUserInfo(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        email,
        phoneNumber,
        birthDate,
      ];
}
