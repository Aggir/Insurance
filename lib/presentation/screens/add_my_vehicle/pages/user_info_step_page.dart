import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/blocs/add_my_vehicle/add_my_vehicle_cubit.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_phone_form_field.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/custom_text_form_field.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_drop_down_field.dart';

class AddMyVehicleUserInfoStepPage extends StatefulWidget {
  const AddMyVehicleUserInfoStepPage({super.key});

  @override
  State<AddMyVehicleUserInfoStepPage> createState() =>
      _AddMyVehicleUserInfoStepPageState();
}

class _AddMyVehicleUserInfoStepPageState
    extends State<AddMyVehicleUserInfoStepPage> {
  void _nextButtonFunction(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (BlocProvider.of<AddMyVehicleCubit>(context).isUserInfoValid()) {
      context.go(Routes.addMyVehicleDetailsStepOneRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppValues.appBarHeight.r -
                AppSizes.s30.r,
            child: PageContentPadding(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: AppSizes.s104.r,
                      width: AppSizes.s104.r,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(100),
                        image: const DecorationImage(
                          image: AssetImage(ImageAssets.addMyVehicleStep1),
                        ),
                      ),
                    ),
                    CustomSpacers.mediumLarge(),
                    Text(
                      AppStrings.personalInfo.tr(),
                      style: largeHeadlineStyle(),
                    ),
                    CustomSpacers.medium(),
                    Text(
                      AppStrings.personalInfoDescription.tr(),
                      style: darkGrayBodyStyle(),
                    ),
                    CustomSpacers.extraLarge(),
                    _userInfoForm(context),
                    const Spacer(),
                    PrimaryButton.fullWidth(
                      onPressed: () => _nextButtonFunction(context),
                      child: Text(AppStrings.next.tr().toUpperCase()),
                    ),
                  ]),
            ),
          ),
        ));
  }

  Widget _userInfoForm(BuildContext context) {
    final cubit = BlocProvider.of<AddMyVehicleCubit>(context);
    return Form(
      key: cubit.userInfoForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.beneficiaryName.tr(), style: darkGrayBodyStyle()),
          CustomSpacers.medium(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              )
            ],
          ),
          CustomSpacers.medium(),
          CustomPhoneFormField(
            hintText: AppStrings.phoneNumberExample.tr(),
            label: AppStrings.phoneNumber.tr(),
            controller: cubit.phoneNumberController,
          ),
          CustomSpacers.medium(),
          CustomDropDownField(
            hintText: AppStrings.selectAddress.tr(),
            items: DUMMY.cities
                .map(
                  (type) => DropdownMenuItem(
                    value: type['value'],
                    child: Text(
                      type['value'] ?? '',
                      style: bodyStyle(),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
