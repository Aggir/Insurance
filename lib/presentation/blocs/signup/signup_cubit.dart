import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/app_strings.dart';

import 'package:insurance_app/app/enums.dart';
import 'package:insurance_app/domain/entities/signup_document_info.dart';
import 'package:insurance_app/domain/entities/signup_user_info.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  final GlobalKey<FormState> userInfoForm = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  final GlobalKey<FormState> passwordForm = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> verificationForm = GlobalKey<FormState>();
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

  toggleIsLibyan() {
    emit(state.copyWith(isLibyan: !state.isLibyan));
  }

  bool confirmUserInfoForm() {
    if (userInfoForm.currentState!.validate()) {
      emit(
        state.copyWith(
          userInfo: SignUpUserInfo(
            firstName: firstNameController.text,
            middleName: middleNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            phoneNumber: phoneNumberController.text,
            birthDate: birthDateController.text,
          ),
        ),
      );
      return true;
    }
    return false;
  }

  bool confirmPasswordForm() {
    if (passwordForm.currentState!.validate()) {
      if (state.isLibyan) {
        emit(state.copyWith(password: passwordController.text));
      } else {
        emit(state.copyWith(
          password: passwordController.text,
          verificationType: AppStrings.passport.tr(),
        ));
      }
      return true;
    }
    return false;
  }

  setVerificationType(String type) {
    emit(state.copyWith(verificationType: type));
  }

  // Todo: add filePicker
  uploadDocumentPicture() async {
    emit(state.copyWith(verificationDocumentStatus: UploadFileStatus.loading));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(verificationDocumentStatus: UploadFileStatus.success));
  }

  removeDocumentPicture() {
    emit(state.copyWith(verificationDocumentStatus: UploadFileStatus.none));
  }

  bool confirmVerificationForm() {
    if (verificationForm.currentState!.validate()) {
      if (state.isLibyan) {
        emit(state.copyWith(
            verificationDocumentInfo: SignUpDocumentInfo(
          type: state.verificationType,
          documentNumber: documentNumberController.text,
          issuingPlace: documentIssuingPlaceController.text,
          dateOfIssue: documentDateOfIssueController.text,
          dateOfExpiry: documentDateOfExpiryController.text,
        )));
      } else {
        emit(state.copyWith(
            verificationDocumentInfo: SignUpDocumentInfo(
          type: state.verificationType,
          documentNumber: documentNumberController.text,
        )));
      }
      return true;
    }
    return false;
  }

  // Todo: add filePicker
  uploadNationalIdPicture() async {
    emit(state.copyWith(nationalNumberStatus: UploadFileStatus.loading));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(nationalNumberStatus: UploadFileStatus.success));
  }

  removeNationalIdPicture() {
    emit(state.copyWith(nationalNumberStatus: UploadFileStatus.none));
  }

  bool confirmNationalIdNumberForm() {
    if (nationalIdNumberForm.currentState!.validate() && state.isLibyan) {
      emit(state.copyWith(
          nationalIdInfo: SignUpDocumentInfo(
        type: AppStrings.nationalIdNumber.tr(),
        documentNumber: nationalIdNumberController.text,
      )));
      return true;
    }
    return false;
  }

  signUp() {
    print(state);
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
    emit(state.copyWith(verificationType: ''));
  }

  backFromVerificationStepPage() {
    documentNumberController.clear();
    documentIssuingPlaceController.clear();
    documentDateOfIssueController.clear();
    documentDateOfExpiryController.clear();
    emit(state.copyWith(verificationDocumentStatus: UploadFileStatus.none));
  }

  backFromNationalIdNumberPage() {
    nationalIdNumberController.clear();
    emit(state.copyWith(nationalNumberStatus: UploadFileStatus.none));
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
