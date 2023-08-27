import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/data/models/branch_model.dart';
import 'package:insurance_app/domain/entities/branch.dart';

extension BranchModelExtension on BranchModel? {
  BranchEntity toDomain() => this == null
      ? BranchEntity.empty()
      : BranchEntity(
          id: this!.id ?? Constants.zero,
          name: this!.name ?? Constants.empty,
          lat: this!.lat != null ? double.parse(this!.lat!) : Constants.dZero,
          lng: this!.lng != null ? double.parse(this!.lng!) : Constants.dZero,
          companyId: this!.companyId ?? Constants.zero,
        );
}
