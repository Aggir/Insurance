enum UploadFileStatus {
  none,
  loading,
  success,
  failure,
}

extension UploadFileStatusExtension on UploadFileStatus {
  bool get isNone => this == UploadFileStatus.none;
  bool get isLoading => this == UploadFileStatus.loading;
  bool get isSuccess => this == UploadFileStatus.success;
  bool get isFailure => this == UploadFileStatus.failure;
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
