import 'package:insurance_app/data/requests/base_request.dart';

class CalculateInsurancePriceRequest implements BaseRequest {
  final int companyId;
  final int insuranceTypeId;
  final int vehicleId;
  const CalculateInsurancePriceRequest({
    required this.companyId,
    required this.insuranceTypeId,
    required this.vehicleId,
  });

  Map<String, dynamic> toMap() {
    return {
      'company_id': companyId,
      'insurance_type_id': insuranceTypeId,
      'vehicle_id': vehicleId,
    };
  }
}

class IssueInsuranceRequest implements BaseRequest {
  final int companyId;
  final int insuranceTypeId;
  final int vehicleId;
  final String startDate;
  final String endDate;

  const IssueInsuranceRequest({
    required this.companyId,
    required this.insuranceTypeId,
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'company_id': companyId,
      'insurance_type_id': insuranceTypeId,
      'vehicle_id': vehicleId,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}
