import 'package:insurance_app/data/models/insurance_installment_model.dart';
import 'package:insurance_app/data/responses/base_response.dart';

class InstallmentsResponse implements BaseResponse {
  @override
  int? code;

  @override
  String? message;

  InsuranceInstallmentModel? installmentModel;

  InstallmentsResponse({
    this.code,
    this.message,
    this.installmentModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'installmentModel': installmentModel?.toMap(),
    };
  }

  factory InstallmentsResponse.fromMap(Map<String, dynamic> map) {
    return InstallmentsResponse(
      code: map['code']?.toInt(),
      message: map['message'],
      installmentModel: InsuranceInstallmentModel.fromMap(map),
    );
  }
}
