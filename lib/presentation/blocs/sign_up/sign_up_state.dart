part of 'sign_up_cubit.dart';

@immutable
class SignUpState extends Equatable {
  final Gender gender;
  final SignUpUserInfo? userInfo;
  final Status checkUserInfo;
  final String? phoneCode;
  final String? checkUserInfoErrorMessage;
  final String? password;
  final bool isLibyan;
  final ProofType? proofType;
  final Status proofStatus;
  final File? proofFile;
  final String? proofFileName;
  final ProofDocument? proofDocumentInfo;
  final Status checkProofId;
  final String? checkProofIdErrorMessage;
  final Status nationalIdStatus;
  final File? nationalFile;
  final String? nationalFileName;
  final NationalDocument? nationalDocumentInfo;
  final Status checkNationalIdStatus;
  final String? checkNationalIdErrorMessage;
  final Status sendVerifyPhoneOtpStatus;
  final String? sendVerifyPhoneOtpErrorMessage;
  const SignUpState({
    this.gender = Gender.male,
    this.userInfo,
    this.checkUserInfo = Status.initial,
    this.phoneCode,
    this.checkUserInfoErrorMessage,
    this.password,
    this.isLibyan = true,
    this.proofType,
    this.proofStatus = Status.initial,
    this.proofFile,
    this.proofFileName,
    this.proofDocumentInfo,
    this.checkProofId = Status.initial,
    this.checkProofIdErrorMessage,
    this.nationalIdStatus = Status.initial,
    this.nationalFile,
    this.nationalFileName,
    this.nationalDocumentInfo,
    this.checkNationalIdStatus = Status.initial,
    this.checkNationalIdErrorMessage,
    this.sendVerifyPhoneOtpStatus = Status.initial,
    this.sendVerifyPhoneOtpErrorMessage,
  });

  @override
  List<Object?> get props {
    return [
      gender,
      userInfo,
      checkUserInfo,
      checkUserInfoErrorMessage,
      phoneCode,
      password,
      isLibyan,
      proofType,
      proofStatus,
      proofFile,
      proofFileName,
      proofDocumentInfo,
      checkProofId,
      checkProofIdErrorMessage,
      nationalIdStatus,
      nationalFile,
      nationalFileName,
      nationalDocumentInfo,
      checkNationalIdStatus,
      checkNationalIdErrorMessage,
      sendVerifyPhoneOtpStatus,
      sendVerifyPhoneOtpErrorMessage,
    ];
  }

  SignUpState copyWith({
    Gender? gender,
    SignUpUserInfo? userInfo,
    Status? checkUserInfo,
    String? checkUserInfoErrorMessage,
    String? phoneCode,
    String? password,
    bool? isLibyan,
    ProofType? proofType,
    Status? proofStatus,
    File? proofFile,
    String? proofFileName,
    ProofDocument? proofDocumentInfo,
    Status? checkProofId,
    String? checkProofIdErrorMessage,
    Status? nationalIdStatus,
    File? nationalFile,
    String? nationalFileName,
    NationalDocument? nationalDocumentInfo,
    bool removeProofFile = false,
    bool removeNationalFile = false,
    Status? checkNationalIdStatus,
    String? checkNationalIdErrorMessage,
    Status? sendVerifyPhoneOtpStatus,
    String? sendVerifyPhoneOtpErrorMessage,
  }) {
    return SignUpState(
      gender: gender ?? this.gender,
      userInfo: userInfo ?? this.userInfo,
      checkUserInfo: checkUserInfo ?? this.checkUserInfo,
      checkUserInfoErrorMessage:
          checkUserInfoErrorMessage ?? this.checkUserInfoErrorMessage,
      phoneCode: phoneCode ?? this.phoneCode,
      password: password ?? this.password,
      isLibyan: isLibyan ?? this.isLibyan,
      proofType: proofType ?? this.proofType,
      proofStatus: proofStatus ?? this.proofStatus,
      proofFile: removeProofFile ? null : proofFile ?? this.proofFile,
      proofFileName:
          removeProofFile ? null : proofFileName ?? this.proofFileName,
      proofDocumentInfo: proofDocumentInfo ?? this.proofDocumentInfo,
      checkProofId: checkProofId ?? this.checkProofId,
      checkProofIdErrorMessage:
          checkProofIdErrorMessage ?? this.checkProofIdErrorMessage,
      nationalIdStatus: nationalIdStatus ?? this.nationalIdStatus,
      nationalFile: removeProofFile ? null : nationalFile ?? this.nationalFile,
      nationalFileName:
          removeProofFile ? null : nationalFileName ?? this.nationalFileName,
      nationalDocumentInfo: nationalDocumentInfo ?? this.nationalDocumentInfo,
      checkNationalIdStatus:
          checkNationalIdStatus ?? this.checkNationalIdStatus,
      checkNationalIdErrorMessage:
          checkNationalIdErrorMessage ?? this.checkNationalIdErrorMessage,
      sendVerifyPhoneOtpStatus:
          sendVerifyPhoneOtpStatus ?? this.sendVerifyPhoneOtpStatus,
      sendVerifyPhoneOtpErrorMessage:
          sendVerifyPhoneOtpErrorMessage ?? this.sendVerifyPhoneOtpErrorMessage,
    );
  }

  @override
  String toString() {
    return 'SignUpState(gender: $gender, userInfo: $userInfo, checkUserInfo: $checkUserInfo, password: $password, isLibyan: $isLibyan, proofType: $proofType, proofStatus: $proofStatus, proofFile: $proofFile, proofFileName: $proofFileName, proofDocumentInfo: $proofDocumentInfo, nationalIdStatus: $nationalIdStatus, nationalFile: $nationalFile, nationalFileName: $nationalFileName, nationalDocumentInfo: $nationalDocumentInfo)';
  }
}
