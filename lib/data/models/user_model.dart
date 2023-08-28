import 'package:equatable/equatable.dart';
import 'package:insurance_app/app/constants.dart';

class UserModel extends Equatable {
  final int? id;
  final String? uniqueId;
  final String? firstName;
  final String? fatherName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? phoneCode;
  final String? photo;
  final String? dateOfBirth;
  final String? gender;
  final String? proofType;
  final bool? isActive;
  final bool? isLibyan;
  final String? proofFile;
  final String? proofId;
  final String? proofIssuePlace;
  final String? proofIssueDate;
  final String? proofExpirationDate;
  final String? nationalId;
  final String? nationalFile;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;

  const UserModel({
    this.id,
    this.uniqueId,
    this.firstName,
    this.fatherName,
    this.lastName,
    this.email,
    this.phone,
    this.phoneCode,
    this.photo,
    this.dateOfBirth,
    this.gender,
    this.proofType,
    this.isActive,
    this.isLibyan,
    this.proofFile,
    this.proofId,
    this.proofIssuePlace,
    this.proofIssueDate,
    this.proofExpirationDate,
    this.nationalId,
    this.nationalFile,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      uniqueId,
      firstName,
      fatherName,
      lastName,
      email,
      phone,
      phoneCode,
      photo,
      dateOfBirth,
      gender,
      proofType,
      isActive,
      isLibyan,
      proofFile,
      proofId,
      proofIssuePlace,
      proofIssueDate,
      proofExpirationDate,
      nationalId,
      nationalFile,
      emailVerifiedAt,
      createdAt,
      updatedAt,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unique_id': id,
      'first_name': firstName,
      'father_name': fatherName,
      'last_name': lastName,
      'email': email,
      'phone': ((phoneCode ?? Constants.empty) + (phone ?? Constants.empty))
          .replaceFirst('+', ''),
      'phone_code': phoneCode,
      'photo': photo,
      'dob': dateOfBirth,
      'gender': gender,
      'proof_type': proofType,
      'is_active': isActive,
      'is_libyan': isLibyan,
      'proof_file': proofFile,
      'proof_id': proofId,
      'proof_issue_place': proofIssuePlace,
      'proof_issue_date': proofIssueDate,
      'proof_expiration_date': proofExpirationDate,
      'national_id': nationalId,
      'national_file': nationalFile,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      uniqueId: map['unique_id'],
      firstName: map['first_name'],
      fatherName: map['father_name'],
      lastName: map['last_name'],
      email: map['email'],
      phone: map['phone'],
      phoneCode: map['phone_code'],
      photo: map['photo'],
      dateOfBirth: map['dob'],
      gender: map['gender'],
      proofType: map['proof_type'],
      isActive: map['is_active'],
      isLibyan: map['is_libyan'] == '1' || map['is_libyan'] == true,
      proofFile: map['proof_file'],
      proofId: map['proof_id'],
      proofIssuePlace: map['proof_issue_place'],
      proofIssueDate: map['proof_issue_date'],
      proofExpirationDate: map['proof_expiration_date'],
      nationalId: map['national_id'],
      nationalFile: map['national_file'],
      emailVerifiedAt: map['email_verified_at'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, fatherName: $fatherName, lastName: $lastName, email: $email, phone: $phone, photo: $photo, dateOfBirth: $dateOfBirth, gender: $gender, proofType: $proofType, isActive: $isActive, isLibyan: $isLibyan, proofFile: $proofFile, proofId: $proofId, proofIssuePlace: $proofIssuePlace, proofIssueDate: $proofIssueDate, proofExpirationDate: $proofExpirationDate, nationalId: $nationalId, nationalFile: $nationalFile, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
