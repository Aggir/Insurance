import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState(isLibyan: DUMMY.isLibyan));

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  init() {
    emit(state.copyWith(fetchAccount: Status.loading));
    firstNameController.text = DUMMY.fistName;
    middleNameController.text = DUMMY.middleName;
    lastNameController.text = DUMMY.lastName;
    emailController.text = DUMMY.email;
    phoneNumberController.text = DUMMY.phone;
    birthDateController.text = DUMMY.birthDate;
    emit(state.copyWith(fetchAccount: Status.success));
  }

  toggleIsEditing() {
    emit(state.copyWith(isEditing: !state.isEditing));
  }

  toggleIsLibyan() {
    emit(state.copyWith(isLibyan: !state.isLibyan!));
  }

  editAccount() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(editStatus: Status.loading));
      DUMMY.fistName = firstNameController.text;
      DUMMY.middleName = middleNameController.text;
      DUMMY.lastName = lastNameController.text;
      DUMMY.email = emailController.text;
      DUMMY.phone = phoneNumberController.text;
      DUMMY.birthDate = birthDateController.text;
      DUMMY.isLibyan = state.isLibyan ?? false;

      emit(state.copyWith(editStatus: Status.success, isEditing: false));
    }
  }
}
