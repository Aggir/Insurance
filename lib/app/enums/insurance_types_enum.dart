import 'package:flutter/material.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';

enum InsuranceStatus {
  underProcessing,
  issued,
  notPaid,
  expired,
}

extension InsuranceStatusExtension on InsuranceStatus {
  bool get isUnderProcessing => this == InsuranceStatus.underProcessing;
  bool get isIssued => this == InsuranceStatus.issued;
  bool get isNotPaid => this == InsuranceStatus.notPaid;
  bool get isExpired => this == InsuranceStatus.expired;

  String get string {
    switch (this) {
      case InsuranceStatus.underProcessing:
        return AppStrings.underProcessing;
      case InsuranceStatus.issued:
        return AppStrings.issuedInsurance;
      case InsuranceStatus.notPaid:
        return AppStrings.notPaid;
      case InsuranceStatus.expired:
        return AppStrings.expiredInsurance;
    }
  }

  String get svgPath {
    switch (this) {
      case InsuranceStatus.underProcessing:
        return SvgAssets.search;
      case InsuranceStatus.issued:
        return SvgAssets.shield;
      case InsuranceStatus.notPaid:
        return SvgAssets.creditCard;
      case InsuranceStatus.expired:
        return SvgAssets.clock;
    }
  }

  Color get svgColor {
    switch (this) {
      case InsuranceStatus.underProcessing:
        return AppColors.gray;
      case InsuranceStatus.issued:
        return AppColors.secondary;
      case InsuranceStatus.notPaid:
        return AppColors.primary;
      case InsuranceStatus.expired:
        return AppColors.danger;
    }
  }

  Color get svgBackgroundColor {
    switch (this) {
      case InsuranceStatus.underProcessing:
        return AppColors.grayLight;
      case InsuranceStatus.issued:
        return AppColors.secondaryLight;
      case InsuranceStatus.notPaid:
        return AppColors.primaryLight;
      case InsuranceStatus.expired:
        return AppColors.primaryLight2;
    }
  }
}
