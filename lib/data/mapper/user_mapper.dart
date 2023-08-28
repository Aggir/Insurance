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
      ? UserEntity.empty()
      : UserEntity(
          userId: this!.id ?? Constants.zero,
          uniqueId: this!.uniqueId ?? Constants.empty,
          firstName: this!.firstName ?? Constants.empty,
          fatherName: this!.fatherName ?? Constants.empty,
          lastName: this!.lastName ?? Constants.empty,
          email: this!.email ?? Constants.empty,
          phone: (this!.phone?.replaceFirst(
                  (this!.phoneCode ?? Constants.empty).replaceFirst('+', ''),
                  '')) ??
              Constants.empty,
          phoneCode: this!.phoneCode ?? Constants.empty,
          imageUrl: this!.photo ?? Constants.empty,
          isLibyan: this!.isLibyan ?? false,
          dateOfBirth: this!.dateOfBirth ?? Constants.empty,
          gender: this!.gender.toGender(),
          updatedAt: this!.updatedAt ?? Constants.empty,
        );
}
