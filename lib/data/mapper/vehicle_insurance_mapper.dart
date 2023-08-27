import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/enums/insurance_status.dart';
import 'package:insurance_app/data/models/vehicle_insurance_model.dart';
import 'package:insurance_app/domain/entities/vehicle_insurance.dart';

extension VehicleInsuranceModelExtension on VehicleInsuranceModel? {
  VehicleInsuranceEntity? toDomain() => this == null
      ? null
      : VehicleInsuranceEntity(
          id: this?.id ?? Constants.zero,
          userId: this?.userId ?? Constants.zero,
          companyId: this?.companyId ?? Constants.zero,
          vehicleId: this?.vehicleId ?? Constants.zero,
          insuranceTypeId: this?.insuranceTypeId ?? Constants.zero,
          isPaid: this?.isPaid ?? false,
          file: this?.file ?? Constants.empty,
          cost: this?.cost ?? Constants.empty,
          startDate: this?.startDate ?? Constants.empty,
          endDate: this?.endDate ?? Constants.empty,
          status: this?.status == null
              ? InsuranceStatus.processing
              : this!.status!.toInsuranceStatus());
}
