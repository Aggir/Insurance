import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/requests/user_requests.dart';
import 'package:insurance_app/domain/repositories/user_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class ResetPasswordUsecase
    implements BaseUsecase<ResetPasswordUsecaseInput, void> {
  final UserRepository _repository;

  ResetPasswordUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(ResetPasswordUsecaseInput input) async {
    return await _repository.resetPassword(ResetPasswordRequest(
        email: input.email, otp: input.otp, password: input.password));
  }
}

class ResetPasswordUsecaseInput {
  final String email;
  final String otp;
  final String password;

  ResetPasswordUsecaseInput({
    required this.email,
    required this.otp,
    required this.password,
  });
}
