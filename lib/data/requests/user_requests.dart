import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:insurance_app/app/extensions.dart';

import 'base_request.dart';

class SignInRequest implements BaseRequest {
  final String email;
  final String password;
  const SignInRequest({
    required this.email,
    required this.password,
  });

  @override
  String toString() => 'SignInRequest(email: $email, password: $password)';

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}

class SignUpRequest implements BaseRequest {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phone;
  final String phoneCode;
  final String dateOfBirth;
  final String gender;
  final String password;
  final bool isLibyan;
  final String proofType;
  final File proofFile;
  final String proofId;
  final String proofIssuePlace;
  final String proofIssueDate;
  final String proofExpirationDate;
  final String? nationalId;
  final File? nationalFile;

  const SignUpRequest({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.phoneCode,
    required this.dateOfBirth,
    required this.gender,
    required this.password,
    required this.isLibyan,
    required this.proofType,
    required this.proofFile,
    required this.proofId,
    required this.proofIssuePlace,
    required this.proofIssueDate,
    required this.proofExpirationDate,
    this.nationalId,
    this.nationalFile,
  });

  Future<Map<String, dynamic>> toMap() async {
    return {
      'first_name': firstName,
      'father_name': middleName,
      'last_name': lastName,
      'email': email,
      'phone': (phoneCode + phone).replaceFirst('+', ''),
      'phone_code': phoneCode,
      'dob': dateOfBirth,
      'gender': gender,
      'password': password,
      'password_confirmation': password,
      'is_libyan': isLibyan.asString,
      'proof_type': proofType,
      'proof_file': await MultipartFile.fromFile(proofFile.path),
      'proof_id': proofId,
      'proof_issue_place': proofIssuePlace,
      'proof_issue_date': proofIssueDate,
      'proof_expiration_date': proofExpirationDate,
      'national_id': nationalId,
      'national_file': nationalFile != null
          ? await MultipartFile.fromFile(nationalFile!.path)
          : nationalFile,
    };
  }

  @override
  String toString() {
    return 'SignUpRequest(firstName: $firstName, middleName: $middleName, lastName: $lastName, email: $email, phone: $phone, dateOfBirth: $dateOfBirth, gender: $gender, password: $password, isLibyan: $isLibyan, proofType: $proofType, proofFile: $proofFile, proofId: $proofId, proofIssuePlace: $proofIssuePlace, proofIssueDate: $proofIssueDate, proofExpirationDate: $proofExpirationDate, nationalId: $nationalId, nationalFile: $nationalFile)';
  }
}

class CheckUserInfoRequest implements BaseRequest {
  final String email;
  final String phone;
  CheckUserInfoRequest({
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone': phone,
    };
  }
}

class EditProfileRequest implements BaseRequest {
  final String firstName;
  final String fatherName;
  final String lastName;
  final String email;
  final String phone;
  final String phoneCode;
  final String dob;
  final File? photo;

  EditProfileRequest({
    required this.firstName,
    required this.fatherName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.phoneCode,
    required this.dob,
    this.photo,
  });

  Future<Map<String, dynamic>> toMap() async {
    final Map<String, dynamic> map = {
      'first_name': firstName,
      'father_name': fatherName,
      'last_name': lastName,
      'email': email,
      'phone': (phoneCode + phone).replaceFirst('+', ''),
      'phone_code': phoneCode,
      'dob': dob,
    };
    if (photo != null) {
      map['photo'] = await MultipartFile.fromFile(photo!.path);
    }
    return map;
  }
}

class ChangePasswordRequest implements BaseRequest {
  final String currentPassword;
  final String newPassword;
  ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPassword,
    };
  }
}

class VerifyOtpForgotPasswordRequest implements BaseRequest {
  final String email;
  final String otp;
  VerifyOtpForgotPasswordRequest({
    required this.email,
    required this.otp,
  });
}

class ResetPasswordRequest implements BaseRequest {
  final String email;
  final String otp;
  final String password;

  ResetPasswordRequest({
    required this.email,
    required this.otp,
    required this.password,
  });

  Map<String, dynamic> toBody() => {
        'password': password,
        'password_confirmation': password,
      };
}
