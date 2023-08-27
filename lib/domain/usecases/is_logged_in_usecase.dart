import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/repositories/user_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

import '../entities/user.dart';

class IsLoggedInUsecase implements BaseUsecase<void, UserEntity> {
  final UserRepository _repository;
  const IsLoggedInUsecase(this._repository);
  @override
  Future<Either<Failure, UserEntity>> execute(input) async {
    return await _repository.isLoggedIn();
  }
}
