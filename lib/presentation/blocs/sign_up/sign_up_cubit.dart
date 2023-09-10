import 'dart:io';

import 'package:barcode_finder/barcode_finder.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/proof_type.dart';
import 'package:insurance_app/app/enums/gender.dart';

import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/app/functions.dart';
import 'package:insurance_app/domain/data_classes/national_document.dart';
import 'package:insurance_app/domain/data_classes/proof_document.dart';
import 'package:insurance_app/domain/entities/signup_user_info.dart';
import 'package:insurance_app/domain/usecases/check_national_id_usecase.dart';
import 'package:insurance_app/domain/usecases/check_proof_id_usecase.dart';
import 'package:insurance_app/domain/usecases/check_user_info.dart';
import 'package:insurance_app/domain/usecases/send_verify_phone_otp_usecase.dart';
import 'package:scan/scan.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  final GlobalKey<FormState> userInfoForm = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode middleNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();

  final GlobalKey<FormState> passwordForm = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> proofInfoForm = GlobalKey<FormState>();
  final TextEditingController documentNumberController =
      TextEditingController();
  final TextEditingController documentIssuingPlaceController =
      TextEditingController();
  final TextEditingController documentDateOfIssueController =
      TextEditingController();
  final TextEditingController documentDateOfExpiryController =
      TextEditingController();

  final GlobalKey<FormState> nationalIdNumberForm = GlobalKey<FormState>();
  final TextEditingController nationalIdNumberController =
      TextEditingController();

  final GlobalKey<FormState> otpForm = GlobalKey();
  final TextEditingController otpController = TextEditingController();

  unfocusUserInfoForm() {
    firstNameFocusNode.unfocus();
    middleNameFocusNode.unfocus();
    lastNameFocusNode.unfocus();
    emailFocusNode.unfocus();
    phoneNumberFocusNode.unfocus();
  }

  unfocusAllNodes() {
    firstNameFocusNode.unfocus();
    middleNameFocusNode.unfocus();
    lastNameFocusNode.unfocus();
    emailFocusNode.unfocus();
    phoneNumberFocusNode.unfocus();
  }

  toggleIsLibyan() {
    emit(state.copyWith(isLibyan: !state.isLibyan));
  }

  setGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  bool isUserInfoFormValid() => userInfoForm.currentState?.validate() ?? false;

  Future<void> confirmUserInfoForm() async {
    emit(state.copyWith(checkUserInfo: Status.loading));
    initCheckUserInfo();
    (await instance<CheckUserInfoUsecase>().execute(CheckUserInfoUsecaseInput(
            email: emailController.text.trim(),
            phone: ((state.phoneCode ?? Constants.empty) +
                    phoneNumberController.text.trim())
                .replaceFirst('+', ''))))
        .fold((failure) {
      emit(state.copyWith(
        checkUserInfo: Status.failure,
        checkUserInfoErrorMessage: failure.message,
      ));
    }, (r) {
      emit(
        state.copyWith(
          checkUserInfo: Status.success,
          userInfo: SignUpUserInfo(
            firstName: firstNameController.text,
            middleName: middleNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            phoneNumber: phoneNumberController.text,
            phoneCode: state.phoneCode!,
            birthDate: birthDateController.text,
            gender: state.gender,
          ),
        ),
      );
    });
  }

  selectPhoneCode(String phoneCode) {
    emit(state.copyWith(phoneCode: phoneCode));
  }

  bool confirmPasswordForm() {
    if (passwordForm.currentState!.validate()) {
      if (state.isLibyan) {
        emit(state.copyWith(password: passwordController.text));
      } else {
        emit(state.copyWith(
          password: passwordController.text,
          proofType: ProofType.passport,
        ));
      }
      return true;
    }
    return false;
  }

  setDocumentType(ProofType type) {
    emit(state.copyWith(proofType: type));
  }

  uploadVerificationDocument() async {
    emit(state.copyWith(proofStatus: Status.loading));
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: Constants.allowedDocumentExtensions,
    );
    if (result != null) {
      final PlatformFile firstFile = result.files.first;
      emit(state.copyWith(
        proofFileName: firstFile.name,
        proofStatus: Status.success,
        proofFile: File(firstFile.path!),
      ));
    } else {
      emit(state.copyWith(proofStatus: Status.initial));
    }
  }

  removeDocumentPicture() {
    emit(state.copyWith(
      proofStatus: Status.initial,
      removeProofFile: true,
    ));
  }

  Future<bool> confirmProofInfoForm() async {
    if (proofInfoForm.currentState!.validate()) {
      emit(state.copyWith(checkProofId: Status.loading));
      initCheckProofId();
      (await instance<CheckProofIdUsecase>()
              .execute(documentNumberController.text.trim()))
          .fold((failure) {
        emit(state.copyWith(
          checkProofId: Status.failure,
          checkProofIdErrorMessage: failure.message,
        ));
      }, (r) {
        emit(
          state.copyWith(
            checkProofId: Status.success,
            proofDocumentInfo: ProofDocument(
              proofType: state.proofType!,
              proofFile: state.proofFile!,
              proofId: documentNumberController.text,
              issuePlace: documentIssuingPlaceController.text,
              issueDate: documentDateOfIssueController.text,
              expirationDate: documentDateOfExpiryController.text,
            ),
          ),
        );
      });
      return state.checkProofId.isSuccess;
    }
    return false;
  }

  uploadNationalIdPicture() async {
    emit(state.copyWith(nationalIdStatus: Status.loading));
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: Constants.allowedDocumentExtensions,
    );
    if (result != null) {
      final PlatformFile firstFile = result.files.first;
      String? scannedNationalId;
      if (firstFile.extension == 'pdf') {
        final resp = await BarcodeFinder.scanFile(path: firstFile.path!);
        scannedNationalId = extractValue(resp, 'NID');
      } else {
        final resp = await Scan.parse(firstFile.path!);
        scannedNationalId = extractValue(resp, 'NID');
      }
      nationalIdNumberController.text = scannedNationalId ?? Constants.empty;
      emit(state.copyWith(
        nationalFileName: firstFile.name,
        nationalIdStatus: Status.success,
        nationalFile: File(firstFile.path!),
      ));
    } else {
      emit(state.copyWith(nationalIdStatus: Status.initial));
    }
  }

  removeNationalIdPicture() {
    emit(state.copyWith(
      nationalIdStatus: Status.initial,
      removeNationalFile: true,
    ));
  }

  Future<bool> confirmNationalIdNumberForm() async {
    if (nationalIdNumberForm.currentState!.validate() &&
        state.nationalFile != null) {
      emit(state.copyWith(checkNationalIdStatus: Status.loading));
      initCheckNationalId();
      (await instance<CheckNationalIdUsecase>()
              .execute(nationalIdNumberController.text.trim()))
          .fold(
        (failure) => emit(state.copyWith(
            checkNationalIdStatus: Status.failure,
            checkNationalIdErrorMessage: failure.message)),
        (_) => emit(state.copyWith(
          checkNationalIdStatus: Status.success,
          nationalDocumentInfo: NationalDocument(
            nationalId: nationalIdNumberController.text,
            nationalFile: state.nationalFile!,
          ),
        )),
      );
    }
    return state.checkNationalIdStatus.isSuccess;
  }

  void sendVerifyPhoneOtp() async {
    emit(state.copyWith(sendVerifyPhoneOtpStatus: Status.loading));
    // Future.delayed(const Duration(seconds: 2)).then(
    //   (value) {
    //     emit(state.copyWith(sendVerifyPhoneOtpStatus: Status.success));
    //   },
    // );
    initSignUpSendVerifyPhoneOtp();
    (await instance<SendVerifyPhoneOtpUsecase>().execute(
            '${state.phoneCode?.replaceFirst('+', '')}${phoneNumberController.text}'))
        .fold(
            (failure) => emit(state.copyWith(
                sendVerifyPhoneOtpStatus: Status.failure,
                sendVerifyPhoneOtpErrorMessage: failure.message)),
            (right) =>
                emit(state.copyWith(sendVerifyPhoneOtpStatus: Status.success)));
  }

  backFromUserInfoPage() {
    _clearContent();
    emit(const SignUpState());
  }

  backFromPasswordPage() {
    passwordController.clear();
    confirmPasswordController.clear();
    emit(state.copyWith(password: ''));
  }

  backFromSelectDocumentTypePage() {
    emit(state.copyWith(proofType: null));
  }

  backFromVerificationStepPage() {
    documentNumberController.clear();
    documentIssuingPlaceController.clear();
    documentDateOfIssueController.clear();
    documentDateOfExpiryController.clear();
    emit(state.copyWith(proofStatus: Status.initial, removeProofFile: true));
  }

  backFromNationalIdNumberPage() {
    nationalIdNumberController.clear();
    emit(state.copyWith(nationalIdStatus: Status.initial));
  }

  backFromOtpPage() {
    otpController.clear();
    emit(state.copyWith(
        sendVerifyPhoneOtpStatus: Status.initial,
        checkNationalIdStatus: Status.initial));
  }

  _clearContent() {
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    birthDateController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    documentNumberController.clear();
    documentIssuingPlaceController.clear();
    documentDateOfIssueController.clear();
    documentDateOfExpiryController.clear();
    nationalIdNumberController.clear();
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    birthDateController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    documentNumberController.dispose();
    documentIssuingPlaceController.dispose();
    documentDateOfIssueController.dispose();
    documentDateOfExpiryController.dispose();
    nationalIdNumberController.dispose();
    return super.close();
  }
}
