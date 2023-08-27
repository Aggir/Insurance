import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/domain/data_classes/company_prices_form_data.dart';
import 'package:insurance_app/domain/repositories/repository.dart';
import 'package:insurance_app/domain/usecases/base_usecase.dart';

class GetCompanyPricesFormUsecase
    implements BaseUsecase<void, CompanyPricesFormData> {
  final Repository _repository;

  GetCompanyPricesFormUsecase(this._repository);
  @override
  Future<Either<Failure, CompanyPricesFormData>> execute(void input) async {
    return await _repository.getCompanyPricesFormData();
  }
}
