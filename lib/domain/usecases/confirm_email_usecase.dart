import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/repositories/user_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class ConfirmEmailUsecase implements BaseUsecase<void, void> {
  final UserRepository _repository;

  ConfirmEmailUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(void input) async {
    return await _repository.confirmEmail();
  }
}
