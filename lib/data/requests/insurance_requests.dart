import 'package:insurance_app/data/requests/base_request.dart';

class CalculateInsurancePriceByVehicleRequest implements BaseRequest {
  final int companyId;
  final int insuranceTypeId;
  final int vehicleId;
  const CalculateInsurancePriceByVehicleRequest({
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

class CalculateInsurancePriceRequest implements BaseRequest {
  final int companyId;
  final int insuranceTypeId;
  final int vehicleTypeId;
  final String? horsepower;
  final String? maxPassengers;
  final String? weight;
  final bool? withAttachment;
  CalculateInsurancePriceRequest({
    required this.companyId,
    required this.insuranceTypeId,
    required this.vehicleTypeId,
    required this.horsepower,
    required this.maxPassengers,
    required this.weight,
    required this.withAttachment,
  });

  Map<String, dynamic> toQueryParams() {
    return {
      'company_id': companyId,
      'insurance_type_id': insuranceTypeId,
      'vehicle_type_id': vehicleTypeId,
    };
  }

  Map<String, dynamic> toBody() {
    return {
      'horse_power': horsepower,
      'with_attachment': withAttachment,
      'weight': weight,
      'max_passengers': maxPassengers,
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

class CompaniesPricesRequest implements BaseRequest {
  final int insuranceTypeId;
  final int vehicleTypeId;
  final String? horsePower;
  final String? maxPassengers;
  final String? weight;
  final bool? withAttachment;
  final bool isSortByMinimum;
  CompaniesPricesRequest({
    required this.insuranceTypeId,
    required this.vehicleTypeId,
    required this.horsePower,
    required this.maxPassengers,
    required this.weight,
    required this.withAttachment,
    required this.isSortByMinimum,
  });

  Map<String, dynamic> toMap() {
    return {
      'insurance_type_id': insuranceTypeId,
      'vehicle_type_id': vehicleTypeId,
      'horse_power': horsePower,
      'max_passengers': maxPassengers,
      'weight': weight,
      'with_attachment': withAttachment,
      'sortby': isSortByMinimum ? 'asc' : 'desc',
    };
  }
}
