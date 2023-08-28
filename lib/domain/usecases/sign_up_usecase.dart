import 'package:dartz/dartz.dart';
import 'package:insurance_app/domain/data_classes/national_document.dart';
import 'package:insurance_app/domain/entities/signup_user_info.dart';

import 'package:insurance_app/domain/entities/user.dart';
import 'package:insurance_app/domain/data_classes/proof_document.dart';
import 'package:insurance_app/domain/repositories/user_repository.dart';

import '../../app/failure.dart';
import '../../data/requests/user_requests.dart';
import 'base_usecase.dart';

class SignUpUsecase implements BaseUsecase<SignUpUsecaseInput, UserEntity> {
  final UserRepository _repository;
  const SignUpUsecase(this._repository);
  @override
  Future<Either<Failure, UserEntity>> execute(SignUpUsecaseInput input) async {
    return await _repository.signUp(SignUpRequest(
      firstName: input.userInfo.firstName,
      middleName: input.userInfo.middleName,
      lastName: input.userInfo.lastName,
      email: input.userInfo.email,
      phone: input.userInfo.phoneNumber,
      phoneCode: input.userInfo.phoneCode,
      dateOfBirth: input.userInfo.birthDate,
      gender: input.userInfo.gender.name.toUpperCase(),
      password: input.password,
      isLibyan: input.isLibyan,
      proofType: input.proofDocument.proofType.name.toUpperCase(),
      proofFile: input.proofDocument.proofFile,
      proofId: input.proofDocument.proofId,
      proofIssuePlace: input.proofDocument.issuePlace,
      proofIssueDate: input.proofDocument.issueDate,
      proofExpirationDate: input.proofDocument.expirationDate,
      nationalId: input.nationalDocument?.nationalId,
      nationalFile: input.nationalDocument?.nationalFile,
    ));
  }
}

class SignUpUsecaseInput {
  final SignUpUserInfo userInfo;
  final String password;
  final bool isLibyan;
  final ProofDocument proofDocument;
  final NationalDocument? nationalDocument;

  const SignUpUsecaseInput({
    required this.userInfo,
    required this.password,
    required this.isLibyan,
    required this.proofDocument,
    this.nationalDocument,
  });
}
