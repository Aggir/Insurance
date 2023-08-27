import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/enums/status_enum.dart';

import '../../../app/constants.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  init(
    String firstName,
    String fatherName,
    String lastName,
    String email,
    String phone,
    String dateOfBirth,
  ) {
    emit(state.copyWith(removePickedPhoto: true));
    firstNameController.text = firstName;
    middleNameController.text = fatherName;
    lastNameController.text = lastName;
    emailController.text = email;
    phoneNumberController.text = phone;
    birthDateController.text = dateOfBirth;
  }

  toggleIsEditing() {
    emit(state.copyWith(
      isEditing: !state.isEditing,
      removePickedPhoto: state.isEditing,
    ));
  }

  bool isFormValid() {
    return formKey.currentState?.validate() ?? false;
  }

  pickPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: Constants.allowedPictureExtensions,
    );
    if (result != null) {
      final PlatformFile firstFile = result.files.first;
      emit(state.copyWith(
        photoFile: File(firstFile.path!),
      ));
    }
  }
}
