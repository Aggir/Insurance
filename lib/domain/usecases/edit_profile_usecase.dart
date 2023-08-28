import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:insurance_app/data/requests/user_requests.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

import '../../app/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class EditProfileUsecase
    implements BaseUsecase<EditProfileUsecaseInput, UserEntity> {
  final UserRepository _repository;
  const EditProfileUsecase(this._repository);
  @override
  Future<Either<Failure, UserEntity>> execute(
      EditProfileUsecaseInput input) async {
    return await _repository.editProfile(EditProfileRequest(
      firstName: input.firstName,
      fatherName: input.fatherName,
      lastName: input.lastName,
      email: input.email,
      phone: input.phone,
      phoneCode: input.phoneCode,
      dob: input.dob,
      photo: input.photo,
    ));
  }
}

class EditProfileUsecaseInput {
  final String firstName;
  final String fatherName;
  final String lastName;
  final String email;
  final String phone;
  final String phoneCode;
  final String dob;
  final File? photo;

  EditProfileUsecaseInput({
    required this.firstName,
    required this.fatherName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.phoneCode,
    required this.dob,
    this.photo,
  });
}
