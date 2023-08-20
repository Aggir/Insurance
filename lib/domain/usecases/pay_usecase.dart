import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/repositories/insurance_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

//TODO: DELETE THIS
class PayUsecase implements BaseUsecase<int, void> {
  final InsuranceRepository _repository;

  PayUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(int insuranceId) async {
    return await _repository.pay(insuranceId);
  }
}
