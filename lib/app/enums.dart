enum Status {
  initial,
  loading,
  success,
  failure,
}

extension StatusExtension on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
}

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
