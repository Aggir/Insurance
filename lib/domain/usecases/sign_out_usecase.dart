import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

import '../repositories/user_repository.dart';

class SignOutUsecase implements BaseUsecase<void, void> {
  final UserRepository _repository;
  const SignOutUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(void input) async {
    return await _repository.signOut();
  }
}
