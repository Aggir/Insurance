class VehicleInsuranceModel {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final String? startDate;
  final String? endDate;
  final String? cost;
  final String? file;
  final bool? isPaid;
  final String? status;
  final int? userId;
  final int? companyId;
  final int? vehicleId;
  final int? insuranceTypeId;

  VehicleInsuranceModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.startDate,
    this.endDate,
    this.cost,
    this.file,
    this.isPaid,
    this.status,
    this.userId,
    this.companyId,
    this.vehicleId,
    this.insuranceTypeId,
  });

  factory VehicleInsuranceModel.fromMap(Map<String, dynamic> map) {
    return VehicleInsuranceModel(
      id: map['id']?.toInt(),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      cost: map['cost'],
      file: map['file'],
      isPaid: map['is_paid'],
      status: map['status'],
      userId: map['user_id']?.toInt(),
      companyId: map['company_id']?.toInt(),
      vehicleId: map['vehicle_id']?.toInt(),
      insuranceTypeId: map['insurance_type_id']?.toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'start_date': startDate,
      'end_date': endDate,
      'cost': cost,
      'file': file,
      'is_paid': isPaid,
      'status': status,
      'user_id': userId,
      'company_id': companyId,
      'vehicle_id': vehicleId,
      'insurance_type_id': insuranceTypeId,
    };
  }
}
