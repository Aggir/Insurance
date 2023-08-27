import 'package:insurance_app/data/models/company_model.dart';
import 'package:insurance_app/data/models/insurance_type_model.dart';
import 'package:insurance_app/data/models/insurance_vehicle_model.dart';

class InsuranceModel {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? startDate;
  final String? endDate;
  final String? cost;
  final String? file;
  final bool? isPaid;
  final String? status;
  final InsuranceVehicleModel? vehicle;
  final CompanyModel? company;
  final InsuranceTypeModel? insuranceType;

  InsuranceModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.startDate,
    this.endDate,
    this.cost,
    this.file,
    this.isPaid,
    this.status,
    this.vehicle,
    this.company,
    this.insuranceType,
  });

  factory InsuranceModel.fromMap(Map<String, dynamic> map) {
    return InsuranceModel(
      id: map['id']?.toInt(),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      cost: map['cost'],
      file: map['file'],
      isPaid: map['is_paid'],
      status: map['status'],
      vehicle: map['vehicle'] != null
          ? InsuranceVehicleModel.fromMap(map['vehicle'])
          : null,
      company:
          map['company'] != null ? CompanyModel.fromMap(map['company']) : null,
      insuranceType: map['insurance_type'] != null
          ? InsuranceTypeModel.fromMap(map['insurance_type'])
          : null,
    );
  }
}
