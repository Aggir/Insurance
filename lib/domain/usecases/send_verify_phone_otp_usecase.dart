import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/repositories/user_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class SendVerifyPhoneOtpUsecase implements BaseUsecase<String, void> {
  final UserRepository _repository;

  SendVerifyPhoneOtpUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(String input) async {
    return await _repository.sendVerifyPhoneOtp(input);
  }
}
