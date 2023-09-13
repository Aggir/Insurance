import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';

enum PaymentMethodEnum {
  mobicash,
  moamalat,
  tadawul,
  sadad,
  nab4pay,
}

extension PaymentMethodExtension on PaymentMethodEnum {
  String get toName {
    switch (this) {
      case PaymentMethodEnum.mobicash:
        return AppStrings.mobicash.tr();
      case PaymentMethodEnum.moamalat:
        return AppStrings.moamalat.tr();
      case PaymentMethodEnum.nab4pay:
        return AppStrings.nab4pay.tr();
      case PaymentMethodEnum.sadad:
        return AppStrings.sadad.tr();
      case PaymentMethodEnum.tadawul:
        return AppStrings.tadawul.tr();
    }
  }

  String get imagePath {
    switch (this) {
      case PaymentMethodEnum.mobicash:
        return ImageAssets.mobicash;
      case PaymentMethodEnum.moamalat:
        return ImageAssets.moamalat;
      case PaymentMethodEnum.nab4pay:
        return ImageAssets.nab4pay;
      case PaymentMethodEnum.sadad:
        return ImageAssets.sadad;
      case PaymentMethodEnum.tadawul:
        return ImageAssets.tadawul;
    }
  }

  bool get isMobicash => this == PaymentMethodEnum.mobicash;
  bool get isMoamalat => this == PaymentMethodEnum.moamalat;
  bool get isTadawul => this == PaymentMethodEnum.tadawul;
  bool get isSadad => this == PaymentMethodEnum.sadad;
  bool get isNab4pay => this == PaymentMethodEnum.nab4pay;
}
