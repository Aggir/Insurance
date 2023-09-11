class InsuranceInstallmentModel {
  final int? subServiceId;
  final double? installmentsValue;
  final int? installmentsCount;
  final bool? valid;
  InsuranceInstallmentModel({
    this.subServiceId,
    this.installmentsValue,
    this.installmentsCount,
    this.valid,
  });

  Map<String, dynamic> toMap() {
    return {
      'sub_service_id': subServiceId,
      'installments_value': installmentsValue,
      'installments_count': installmentsCount,
      'valid': valid,
    };
  }

  factory InsuranceInstallmentModel.fromMap(Map<String, dynamic> map) {
    return InsuranceInstallmentModel(
      subServiceId: map['sub_service_id']?.toInt(),
      installmentsValue: map['installments_value'] == null
          ? null
          : double.parse(map['installments_value']),
      installmentsCount: map['installments_count']?.toInt(),
      valid: map['valid'],
    );
  }
}
