enum SignUpVerificationTypes {
  passport,
  idCard,
  nationalIdNumber,
}

extension SignUpVerificationTypesExtension on SignUpVerificationTypes {
  bool get isPassport => this == SignUpVerificationTypes.passport;
  bool get isIdCard => this == SignUpVerificationTypes.idCard;
  bool get isNationalIdNumber =>
      this == SignUpVerificationTypes.nationalIdNumber;
}
