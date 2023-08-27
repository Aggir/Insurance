import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/requests/user_requests.dart';
import 'package:insurance_app/domain/repositories/user_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class VerifyForgotPasswordOtpUsecase
    implements BaseUsecase<VerifyForgotPasswordOtpUsecaseInput, void> {
  final UserRepository _repository;

  VerifyForgotPasswordOtpUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(
      VerifyForgotPasswordOtpUsecaseInput input) async {
    return await _repository.verifyForgotPasswordOtp(
        VerifyOtpForgotPasswordRequest(email: input.email, otp: input.otp));
  }
}

class VerifyForgotPasswordOtpUsecaseInput {
  final String email;
  final String otp;
  VerifyForgotPasswordOtpUsecaseInput({
    required this.email,
    required this.otp,
  });
}
