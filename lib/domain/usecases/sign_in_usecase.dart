import 'package:dartz/dartz.dart';
import 'package:insurance_app/domain/entities/user.dart';
import 'package:insurance_app/domain/repositories/user_repository.dart';

import '../../app/failure.dart';
import '../../data/requests/requests.dart';
import 'base_usecase.dart';

class SignInUsecase implements BaseUsecase<SignInUsecaseInput, UserEntity> {
  final UserRepository _repository;
  const SignInUsecase(this._repository);
  @override
  Future<Either<Failure, UserEntity>> execute(SignInUsecaseInput input) async {
    return await _repository.signIn(SignInRequest(
      email: input.emailAddressOrPhoneNumber,
      password: input.password,
    ));
  }
}

class SignInUsecaseInput {
  final String emailAddressOrPhoneNumber;
  final String password;

  const SignInUsecaseInput({
    required this.emailAddressOrPhoneNumber,
    required this.password,
  });
}
