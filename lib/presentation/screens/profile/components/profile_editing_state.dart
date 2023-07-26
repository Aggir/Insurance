import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_app/presentation/blocs/profile/cubit/profile_cubit.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/app_strings.dart';
import '../../../widgets/cupertino_switch_tile.dart';
import '../../../widgets/custom_form_field_date_picker.dart';
import '../../../widgets/custom_phone_form_field.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/custom_text_form_field.dart';

class ProfileEditingState extends StatelessWidget {
  const ProfileEditingState({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileCubit>(context);
    return Expanded(
      child: Column(
        children: [
          Form(
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
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) => CupertinoSwitchTile(
                    text: AppStrings.iamLibyan.tr(),
                    value: state.isLibyan!,
                    onTap: () =>
                        BlocProvider.of<ProfileCubit>(context).toggleIsLibyan(),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          PrimaryButton.fullWidth(
            child: Text(AppStrings.save.tr()),
            onPressed: () => cubit.editAccount(),
          ),
          CustomSpacers.medium(),
        ],
      ),
    );
  }
}
