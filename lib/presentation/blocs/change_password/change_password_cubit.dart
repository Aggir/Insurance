import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:insurance_app/app/enums/status_enum.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> confirmForm() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(changePasswordStatus: Status.loading));
      await Future.delayed(const Duration(seconds: 1));
      if (currentPasswordController.text == '123456') {
        emit(state.copyWith(
            changePasswordStatus: Status.success,
            currentPassword: currentPasswordController.text,
            newPassword: newPasswordController.text));
      } else {
        emit(
          state.copyWith(
            changePasswordStatus: Status.failure,
            changePasswordError:
                'كلمة المرور غير صحيحة، الرجاء اعادة المحاولة.',
          ),
        );
      }
    }
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
