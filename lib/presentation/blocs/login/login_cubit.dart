import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailAndPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailAndPhoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  void unfocus() {
    emailAndPhoneFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  bool get isFormValid => formKey.currentState?.validate() ?? false;
}
