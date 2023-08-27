import 'package:flutter/material.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';

enum InsuranceTypeStatus {
  underProcessing,
  issued,
  notPaid,
  expired,
}

extension InsuranceStatusExtension on InsuranceTypeStatus {
  bool get isUnderProcessing => this == InsuranceTypeStatus.underProcessing;
  bool get isIssued => this == InsuranceTypeStatus.issued;
  bool get isNotPaid => this == InsuranceTypeStatus.notPaid;
  bool get isExpired => this == InsuranceTypeStatus.expired;

  String get string {
    switch (this) {
      case InsuranceTypeStatus.underProcessing:
        return AppStrings.underProcessing;
      case InsuranceTypeStatus.issued:
        return AppStrings.issuedInsurance;
      case InsuranceTypeStatus.notPaid:
        return AppStrings.notPaid;
      case InsuranceTypeStatus.expired:
        return AppStrings.expiredInsurance;
    }
  }

  String get svgPath {
    switch (this) {
      case InsuranceTypeStatus.underProcessing:
        return SvgAssets.search;
      case InsuranceTypeStatus.issued:
        return SvgAssets.shield;
      case InsuranceTypeStatus.notPaid:
        return SvgAssets.creditCard;
      case InsuranceTypeStatus.expired:
        return SvgAssets.clock;
    }
  }

  Color get svgColor {
    switch (this) {
      case InsuranceTypeStatus.underProcessing:
        return AppColors.gray;
      case InsuranceTypeStatus.issued:
        return AppColors.secondary;
      case InsuranceTypeStatus.notPaid:
        return AppColors.primary;
      case InsuranceTypeStatus.expired:
        return AppColors.danger;
    }
  }

  Color get svgBackgroundColor {
    switch (this) {
      case InsuranceTypeStatus.underProcessing:
        return AppColors.grayLight;
      case InsuranceTypeStatus.issued:
        return AppColors.secondaryLight;
      case InsuranceTypeStatus.notPaid:
        return AppColors.primaryLight;
      case InsuranceTypeStatus.expired:
        return AppColors.primaryLight2;
    }
  }
}
