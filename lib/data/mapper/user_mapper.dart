import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/enums/gender.dart';
import 'package:insurance_app/data/models/user_model.dart';
import 'package:insurance_app/domain/entities/user.dart';

extension UserEntityExtension on UserEntity {
  UserModel toData() => UserModel(
        id: id,
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
      ? UserEntity(
          id: Constants.zero,
          firstName: Constants.empty,
          fatherName: Constants.empty,
          lastName: Constants.empty,
          email: Constants.empty,
          phone: Constants.empty,
          dateOfBirth: DateTime.now(),
          gender: Gender.female)
      : UserEntity(
          id: this!.id ?? Constants.zero,
          firstName: this!.firstName ?? Constants.empty,
          fatherName: this!.fatherName ?? Constants.empty,
          lastName: this!.lastName ?? Constants.empty,
          email: this!.email ?? Constants.empty,
          phone: this!.phone ?? Constants.empty,
          dateOfBirth: this!.dateOfBirth ?? DateTime.now(),
          gender: this!.gender.toGender(),
        );
}
