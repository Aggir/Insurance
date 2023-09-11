import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/domain/entities/insurance_installments.dart';
import 'package:insurance_app/domain/repositories/insurance_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class GetInsuranceInstallmentsUsecase
    implements
        BaseUsecase<GetInsuranceInstallmentsUsecaseInput,
            InsuranceInstallmentsEntity> {
  final InsuranceRepository _repository;

  GetInsuranceInstallmentsUsecase(this._repository);
  @override
  Future<Either<Failure, InsuranceInstallmentsEntity>> execute(
      GetInsuranceInstallmentsUsecaseInput input) async {
    return await _repository.getInsuranceInstallments(
        GetInsuranceInstallmentsRequest(
            companyId: input.companyId,
            serviceId: input.serviceId,
            subServiceId: input.subServiceId,
            userId: input.userId,
            value: input.value));
  }
}

class GetInsuranceInstallmentsUsecaseInput {
  final int companyId;
  final int serviceId;
  final int subServiceId;
  final int userId;
  final double value;
  const GetInsuranceInstallmentsUsecaseInput({
    required this.companyId,
    required this.serviceId,
    required this.subServiceId,
    required this.userId,
    required this.value,
  });
}
