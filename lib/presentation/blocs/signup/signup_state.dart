part of 'signup_cubit.dart';

@immutable
class SignUpState extends Equatable {
  final SignUpUserInfo? userInfo;
  final String? password;
  final bool isLibyan;
  // Todo: Change `verificationType` from String to enum.
  final String verificationType;
  final UploadFileStatus verificationDocumentStatus;
  final SignUpDocumentInfo? verificationDocumentInfo;
  final UploadFileStatus nationalNumberStatus;
  final SignUpDocumentInfo? nationalIdInfo;
  const SignUpState({
    this.userInfo,
    this.password,
    this.isLibyan = true,
    this.verificationType = '',
    this.verificationDocumentStatus = UploadFileStatus.none,
    this.verificationDocumentInfo,
    this.nationalNumberStatus = UploadFileStatus.none,
    this.nationalIdInfo,
  });

  @override
  List<Object?> get props => [
        userInfo,
        password,
        isLibyan,
        verificationType,
        verificationDocumentStatus,
        verificationDocumentInfo,
        nationalNumberStatus,
        nationalIdInfo,
      ];

  SignUpState copyWith({
    SignUpUserInfo? userInfo,
    String? password,
    bool? isLibyan,
    String? verificationType,
    UploadFileStatus? verificationDocumentStatus,
    SignUpDocumentInfo? verificationDocumentInfo,
    UploadFileStatus? nationalNumberStatus,
    SignUpDocumentInfo? nationalIdInfo,
  }) {
    return SignUpState(
      userInfo: userInfo ?? this.userInfo,
      password: password ?? this.password,
      isLibyan: isLibyan ?? this.isLibyan,
      verificationType: verificationType ?? this.verificationType,
      verificationDocumentStatus:
          verificationDocumentStatus ?? this.verificationDocumentStatus,
      verificationDocumentInfo:
          verificationDocumentInfo ?? this.verificationDocumentInfo,
      nationalNumberStatus: nationalNumberStatus ?? this.nationalNumberStatus,
      nationalIdInfo: nationalIdInfo ?? this.nationalIdInfo,
    );
  }

  @override
  String toString() {
    return 'SignUpState(userInfo: $userInfo, password: $password, isLibyan: $isLibyan, verificationType: $verificationType, verificationDocumentStatus: $verificationDocumentStatus, verificationDocumentInfo: $verificationDocumentInfo, nationalNumberStatus: $nationalNumberStatus, nationalIdInfo: $nationalIdInfo)';
  }
}
