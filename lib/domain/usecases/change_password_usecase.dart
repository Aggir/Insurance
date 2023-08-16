import 'package:dartz/dartz.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

import '../../app/failure.dart';
import '../../data/requests/user_requests.dart';
import '../repositories/user_repository.dart';

class ChangePasswordUsecase
    implements BaseUsecase<ChangePasswordUsecaseInput, void> {
  final UserRepository _repository;
  const ChangePasswordUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(
      ChangePasswordUsecaseInput input) async {
    return _repository.changePassword(ChangePasswordRequest(
        currentPassword: input.currentPassword,
        newPassword: input.newPassword));
  }
}

class ChangePasswordUsecaseInput {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordUsecaseInput({
    required this.currentPassword,
    required this.newPassword,
  });
}
