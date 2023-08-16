import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? id;
  final String? firstName;
  final String? fatherName;
  final String? lastName;
  final String? email;
  final String? phone;
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
    this.firstName,
    this.fatherName,
    this.lastName,
    this.email,
    this.phone,
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
      firstName,
      fatherName,
      lastName,
      email,
      phone,
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
      'first_name': firstName,
      'father_name': fatherName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
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
      firstName: map['first_name'],
      fatherName: map['father_name'],
      lastName: map['last_name'],
      email: map['email'],
      phone: map['phone'],
      photo: map['photo'],
      dateOfBirth: map['dob'],
      gender: map['gender'],
      proofType: map['proof_type'],
      isActive: map['is_active'],
      isLibyan: map['is_libyan'],
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
}
