part of 'signup_cubit.dart';

@immutable
class SignUpState extends Equatable {
  final SignUpUserInfo? userInfo;
  final String? password;
  final bool isLibyan;
  final UploadFileStatus verificationDocumentStatus;
  // Todo: Change `verificationType` from String to enum.
  final String verificationType;
  final UploadFileStatus nationalNumberStatus;
  const SignUpState({
    this.userInfo,
    this.password,
    this.isLibyan = true,
    this.verificationDocumentStatus = UploadFileStatus.none,
    this.verificationType = '',
    this.nationalNumberStatus = UploadFileStatus.none,
  });

  @override
  List<Object?> get props => [
        userInfo,
        password,
        isLibyan,
        verificationDocumentStatus,
        verificationType,
        nationalNumberStatus,
      ];

  SignUpState copyWith(
      {SignUpUserInfo? userInfo,
      String? password,
      bool? isLibyan,
      UploadFileStatus? verificationDocumentStatus,
      String? verificationType,
      UploadFileStatus? nationalNumberStatus}) {
    return SignUpState(
      userInfo: userInfo ?? this.userInfo,
      password: password ?? this.password,
      isLibyan: isLibyan ?? this.isLibyan,
      verificationDocumentStatus:
          verificationDocumentStatus ?? this.verificationDocumentStatus,
      verificationType: verificationType ?? this.verificationType,
      nationalNumberStatus: nationalNumberStatus ?? this.nationalNumberStatus,
    );
  }
}
