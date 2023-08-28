import 'package:dartz/dartz.dart';

import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/requests/user_requests.dart';
import 'package:insurance_app/domain/repositories/user_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class CheckUserInfoUsecase
    implements BaseUsecase<CheckUserInfoUsecaseInput, void> {
  final UserRepository _repository;
  const CheckUserInfoUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(CheckUserInfoUsecaseInput input) async {
    print(input.phone);
    return await _repository.checkUserInfo(
        CheckUserInfoRequest(email: input.email, phone: input.phone));
  }
}

class CheckUserInfoUsecaseInput {
  final String email;
  final String phone;
  CheckUserInfoUsecaseInput({
    required this.email,
    required this.phone,
  });
}
