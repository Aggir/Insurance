import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/enums/insurance_status.dart';
import 'package:insurance_app/app/enums/insurance_types_enum.dart';
import 'package:insurance_app/data/mapper/company_mapper.dart';
import 'package:insurance_app/data/mapper/insurance_type_mapper.dart';
import 'package:insurance_app/data/mapper/insurance_vehicle_mapper.dart';
import 'package:insurance_app/data/models/insurance_model.dart';
import 'package:insurance_app/domain/entities/company.dart';
import 'package:insurance_app/domain/entities/insurance.dart';
import 'package:insurance_app/domain/entities/insurance_type.dart';
import 'package:insurance_app/domain/entities/insurance_vehicle.dart';

extension InsuranceModelExtension on InsuranceModel? {
  InsuranceTypeStatus _getInsuranceTypeStatus(
      String? statusString, bool isPaid) {
    final InsuranceStatus status =
        (statusString ?? Constants.empty).toInsuranceStatus();
    if (isPaid && status.isActive) {
      return InsuranceTypeStatus.issued;
    } else if (status.isExpire) {
      return InsuranceTypeStatus.expired;
    } else if (!isPaid && status.isProcessing) {
      return InsuranceTypeStatus.notPaid;
    } else {
      return InsuranceTypeStatus.underProcessing;
    }
  }

  InsuranceEntity toDomain() => this == null
      ? InsuranceEntity.empty()
      : InsuranceEntity(
          id: this?.id ?? Constants.zero,
          startDate: this?.startDate ?? Constants.empty,
          endDate: this?.endDate ?? Constants.empty,
          cost: this?.cost ?? Constants.empty,
          file: this?.file ?? Constants.empty,
          isPaid: this?.isPaid ?? false,
          status: (this?.status ?? Constants.empty).toInsuranceStatus(),
          vehicle: this?.vehicle.toDomain() ?? InsuranceVehicleEntity.empty(),
          insuranceType:
              this?.insuranceType.toDomain() ?? InsuranceTypeEntity.empty(),
          company: this?.company.toDomain() ?? CompanyEntity.empty(),
          ref: this?.ref ?? Constants.empty,
          insuranceTypeStatus:
              _getInsuranceTypeStatus(this?.status, this?.isPaid ?? false));
}
