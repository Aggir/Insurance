import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/enums/gender.dart';
import 'package:insurance_app/data/models/user_model.dart';
import 'package:insurance_app/domain/entities/user.dart';

extension UserEntityExtension on UserEntity {
  UserModel toData() => UserModel(
        firstName: firstName,
        fatherName: fatherName,
        lastName: lastName,
        email: email,
        phone: phone,
        dateOfBirth: dateOfBirth,
        gender: gender.name.toUpperCase(),
      );
}

extension UserModelExtension on UserModel? {
  UserEntity toDomain() => this == null
      ? const UserEntity(
          userId: Constants.zero,
          firstName: Constants.empty,
          fatherName: Constants.empty,
          lastName: Constants.empty,
          email: Constants.empty,
          phone: Constants.empty,
          imageUrl: Constants.empty,
          dateOfBirth: Constants.empty,
          isLibyan: true,
          gender: Gender.female,
          updatedAt: Constants.empty,
        )
      : UserEntity(
          userId: this!.id ?? Constants.zero,
          firstName: this!.firstName ?? Constants.empty,
          fatherName: this!.fatherName ?? Constants.empty,
          lastName: this!.lastName ?? Constants.empty,
          email: this!.email ?? Constants.empty,
          phone: this!.phone ?? Constants.empty,
          imageUrl: this!.photo ?? Constants.empty,
          isLibyan: this!.isLibyan ?? false,
          dateOfBirth: this!.dateOfBirth ?? Constants.empty,
          gender: this!.gender.toGender(),
          updatedAt: this!.updatedAt ?? Constants.empty,
        );
}
