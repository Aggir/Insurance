import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/blocs/profile/profile_cubit.dart';
import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/app_strings.dart';
import '../../../widgets/custom_form_field_date_picker.dart';
import '../../../widgets/custom_phone_form_field.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/snackBars.dart';

class ProfileEditingState extends StatelessWidget {
  const ProfileEditingState({super.key});

  _editProfileFunction(BuildContext context, ProfileState state) {
    final cubit = BlocProvider.of<ProfileCubit>(context);
    if (cubit.isFormValid()) {
      DialogService.loadLoadingDialog(context);
      BlocProvider.of<UserCubit>(context).editProfile(
        cubit.firstNameController.text.trim(),
        cubit.middleNameController.text.trim(),
        cubit.lastNameController.text.trim(),
        cubit.emailController.text.trim(),
        cubit.phoneNumberController.text.trim(),
        cubit.birthDateController.text.trim(),
        photo: state.photoFile,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileCubit>(context);
    return Expanded(
      child: Column(
        children: [
          BlocListener<UserCubit, UserState>(
            listenWhen: (previous, current) =>
                previous.editProfileStatus != current.editProfileStatus,
            listener: (context, state) {
              if (state.editProfileStatus.isFailure) {
                DialogService.dispose();
                SnackBars.error(context, state.editProfileErrorMessage!);
              } else if (state.editProfileStatus.isSuccess) {
                DialogService.dispose();
                SnackBars.success(
                  context,
                  AppStrings.editProfileSuccessMessage.tr(),
                );
                cubit.toggleIsEditing();
              }
            },
            child: Form(
              key: cubit.formKey,
              // onChanged: _checkIsFormEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: CustomTextFormField(
                          hintText: AppStrings.firstName.tr(),
                          controller: cubit.firstNameController,
                        ),
                      ),
                      CustomSpacers.extraSmall(),
                      Flexible(
                        child: CustomTextFormField(
                          hintText: AppStrings.middleName.tr(),
                          controller: cubit.middleNameController,
                        ),
                      ),
                      CustomSpacers.extraSmall(),
                      Flexible(
                        child: CustomTextFormField(
                          hintText: AppStrings.lastName.tr(),
                          controller: cubit.lastNameController,
                        ),
                      ),
                    ],
                  ),
                  CustomSpacers.medium(),
                  CustomTextFormField(
                    hintText: AppStrings.emailAddress.tr(),
                    controller: cubit.emailController,
                  ),
                  CustomSpacers.medium(),
                  CustomPhoneFormField(
                    hintText: AppStrings.phoneNumberExample.tr(),
                    label: AppStrings.phoneNumber.tr(),
                    controller: cubit.phoneNumberController,
                  ),
                  CustomSpacers.medium(),
                  CustomFormFieldDatePicker(
                    hintText: AppStrings.birthDate.tr(),
                    controller: cubit.birthDateController,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return PrimaryButton.fullWidth(
                child: Text(AppStrings.save.tr()),
                onPressed: () => _editProfileFunction(context, state),
              );
            },
          ),
          CustomSpacers.medium(),
        ],
      ),
    );
  }
}
