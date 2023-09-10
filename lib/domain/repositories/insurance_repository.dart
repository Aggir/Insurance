import 'package:dartz/dartz.dart';
import 'package:insurance_app/app/failure.dart';
import 'package:insurance_app/data/requests/insurance_requests.dart';
import 'package:insurance_app/domain/data_classes/insurances_page.dart';
import 'package:insurance_app/domain/data_classes/issue_insurance_form_data.dart';
import 'package:insurance_app/domain/entities/company_price.dart';
import 'package:insurance_app/domain/entities/insurance_type.dart';

abstract class InsuranceRepository {
  Future<Either<Failure, IssueInsuranceFormData>> getInsuranceFormData();

  Future<Either<Failure, String>> calculateInsurancePriceByVehicle(
      CalculateInsurancePriceByVehicleRequest request);

  Future<Either<Failure, String>> calculateInsurancePrice(
      CalculateInsurancePriceRequest request);

  Future<Either<Failure, int>> issueInsurance(IssueInsuranceRequest request);

  Future<Either<Failure, InsurancesPage>> getMyInsurances({int? page});

  Future<Either<Failure, List<InsuranceTypeEntity>>> getInsuranceTypes();

  Future<Either<Failure, void>> pay(int insuranceId);

  Future<Either<Failure, List<CompanyPriceEntity>>> getCompaniesPrices(
      CompaniesPricesRequest request);
}
