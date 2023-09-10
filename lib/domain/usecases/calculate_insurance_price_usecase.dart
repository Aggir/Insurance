import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/domain/repositories/insurance_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class CalculateInsurancePriceUsecase
    implements BaseUsecase<CalculateInsurancePriceUsecaseInput, String> {
  final InsuranceRepository _repository;

  CalculateInsurancePriceUsecase(this._repository);

  @override
  Future<Either<Failure, String>> execute(
      CalculateInsurancePriceUsecaseInput input) async {
    return await _repository
        .calculateInsurancePrice(CalculateInsurancePriceRequest(
      companyId: input.companyId,
      insuranceTypeId: input.insuranceTypeId,
      vehicleTypeId: input.vehicleTypeId,
      horsepower: input.horsepower,
      maxPassengers: input.maxPassengers,
      weight: input.weight,
      withAttachment: input.withAttachment,
    ));
  }
}

class CalculateInsurancePriceUsecaseInput {
  final int companyId;
  final int insuranceTypeId;
  final int vehicleTypeId;
  final String? horsepower;
  final String? maxPassengers;
  final String? weight;
  final bool? withAttachment;
  CalculateInsurancePriceUsecaseInput({
    required this.companyId,
    required this.insuranceTypeId,
    required this.vehicleTypeId,
    required this.horsepower,
    required this.maxPassengers,
    required this.weight,
    required this.withAttachment,
  });
}
