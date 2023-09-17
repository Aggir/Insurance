import 'package:insurance_app/data/requests/index.dart';
import 'package:insurance_app/data/responses/index.dart';

abstract class BaseInsuranceRemoteDatasource {
  Future<InsuranceTypesResponse> getInsuranceTypes();

  Future<BasicResponse> calculateInsurancePriceByVehicle(
      CalculateInsurancePriceByVehicleRequest request);

  Future<BasicResponse> calculateInsurancePrice(
      CalculateInsurancePriceRequest request);

  Future<IssueInsuranceResponse> issueInsurance(IssueInsuranceRequest request);

  Future<InsurancesResponse> getMyInsurances({int? page});

  Future<BasicResponse> pay(int insuranceId);

  Future<InstallmentsResponse> getInsuranceInstallments(
      GetInsuranceInstallmentsRequest request);
}
