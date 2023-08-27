part of 'sign_up_cubit.dart';

@immutable
class SignUpState extends Equatable {
  final Gender gender;
  final SignUpUserInfo? userInfo;
  final Status checkUserInfo;
  final String? checkUserInfoErrorMessage;
  final String? password;
  final bool isLibyan;
  // Todo: Change `verificationType` from String to enum.
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
  const SignUpState({
    this.gender = Gender.male,
    this.userInfo,
    this.checkUserInfo = Status.initial,
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
  });

  @override
  List<Object?> get props {
    return [
      gender,
      userInfo,
      checkUserInfo,
      checkUserInfoErrorMessage,
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
    ];
  }

  SignUpState copyWith({
    Gender? gender,
    SignUpUserInfo? userInfo,
    Status? checkUserInfo,
    String? checkUserInfoErrorMessage,
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
  }) {
    return SignUpState(
      gender: gender ?? this.gender,
      userInfo: userInfo ?? this.userInfo,
      checkUserInfo: checkUserInfo ?? this.checkUserInfo,
      checkUserInfoErrorMessage:
          checkUserInfoErrorMessage ?? this.checkUserInfoErrorMessage,
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
    );
  }

  @override
  String toString() {
    return 'SignUpState(gender: $gender, userInfo: $userInfo, checkUserInfo: $checkUserInfo, password: $password, isLibyan: $isLibyan, proofType: $proofType, proofStatus: $proofStatus, proofFile: $proofFile, proofFileName: $proofFileName, proofDocumentInfo: $proofDocumentInfo, nationalIdStatus: $nationalIdStatus, nationalFile: $nationalFile, nationalFileName: $nationalFileName, nationalDocumentInfo: $nationalDocumentInfo)';
  }
}
