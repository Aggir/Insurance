import 'package:insurance_app/app/app_strings.dart';

enum ProofType {
  passport,
  id,
}

extension DocumentTypeExtension on ProofType {
  bool get isPassport => this == ProofType.passport;
  bool get isId => this == ProofType.id;

  String get toDisplayedText {
    switch (this) {
      case ProofType.passport:
        return AppStrings.passport;
      case ProofType.id:
        return AppStrings.idCard;
    }
  }
}

extension NullableDocumentTypeExtension on ProofType? {
  bool get isPassport => this == ProofType.passport;
  bool get isId => this == ProofType.id;
  bool get isNull => this == null;
}

extension StringToDocumentTypeExtension on String {
  ProofType toDocumentType() {
    switch (toLowerCase()) {
      case 'id':
        return ProofType.id;
      case 'passport':
      default:
        return ProofType.passport;
    }
  }
}
