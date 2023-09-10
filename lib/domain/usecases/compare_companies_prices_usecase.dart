import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/domain/entities/company_price.dart';
import 'package:insurance_app/domain/repositories/insurance_repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class CompareCompaniesPricesUsecase
    implements
        BaseUsecase<CompareCompaniesPricesUsecaseInput,
            List<CompanyPriceEntity>> {
  final InsuranceRepository _repository;

  CompareCompaniesPricesUsecase(this._repository);
  @override
  Future<Either<Failure, List<CompanyPriceEntity>>> execute(
      CompareCompaniesPricesUsecaseInput input) async {
    return await _repository.getCompaniesPrices(CompaniesPricesRequest(
      insuranceTypeId: input.insuranceTypeId,
      horsePower: input.horsePower,
      maxPassengers: input.maxPassengers,
      weight: input.weight,
      withAttachment: input.withAttachment,
      isSortByMinimum: input.isSortByMinimum,
    ));
  }
}

class CompareCompaniesPricesUsecaseInput {
  final int insuranceTypeId;
  final String? horsePower;
  final String? maxPassengers;
  final String? weight;
  final bool? withAttachment;
  final bool isSortByMinimum;
  CompareCompaniesPricesUsecaseInput({
    required this.insuranceTypeId,
    this.horsePower,
    this.maxPassengers,
    this.weight,
    this.withAttachment,
    required this.isSortByMinimum,
  });
}
