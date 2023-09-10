import 'package:dartz/dartz.dart';

import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

import '../repositories/insurance_repository.dart';

class CalculateInsurancePriceByVehicleUsecase
    implements
        BaseUsecase<CalculateInsurancePriceByVehicleUsecaseInput, String> {
  final InsuranceRepository _repository;

  CalculateInsurancePriceByVehicleUsecase(this._repository);
  @override
  Future<Either<Failure, String>> execute(
      CalculateInsurancePriceByVehicleUsecaseInput input) async {
    return await _repository.calculateInsurancePriceByVehicle(
        CalculateInsurancePriceByVehicleRequest(
      companyId: input.companyId,
      insuranceTypeId: input.insuranceTypeId,
      vehicleId: input.vehicleId,
    ));
  }
}

class CalculateInsurancePriceByVehicleUsecaseInput {
  final int companyId;
  final int insuranceTypeId;
  final int vehicleId;
  CalculateInsurancePriceByVehicleUsecaseInput({
    required this.companyId,
    required this.insuranceTypeId,
    required this.vehicleId,
  });
}
