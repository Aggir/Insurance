import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/repositories/user_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class CheckNationalIdUsecase implements BaseUsecase<String, void> {
  final UserRepository _repository;

  CheckNationalIdUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(String nationalId) async {
    return await _repository.checkNationalId(nationalId);
  }
}
