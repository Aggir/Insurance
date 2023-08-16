import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/usecases/change_password_usecase.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isFormValid() => formKey.currentState?.validate() ?? false;

  Future<void> changePassword() async {
    emit(state.copyWith(changePasswordStatus: Status.loading));
    initChangePassword();
    (await instance<ChangePasswordUsecase>().execute(
      ChangePasswordUsecaseInput(
        currentPassword: currentPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
      ),
    ))
        .fold((failure) {
      emit(state.copyWith(
        changePasswordStatus: Status.failure,
        changePasswordError: failure.message,
      ));
    }, (r) {
      emit(
        state.copyWith(
          changePasswordStatus: Status.success,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
