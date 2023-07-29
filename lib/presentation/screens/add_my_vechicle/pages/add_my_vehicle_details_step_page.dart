import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/blocs/add_my_vehicle/add_my_vehicle_cubit.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/custom_text_form_field.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

class AddMyVehicleDetailsStepPage extends StatefulWidget {
  const AddMyVehicleDetailsStepPage({super.key});

  @override
  State<AddMyVehicleDetailsStepPage> createState() =>
      _AddMyVehicleDetailsStepPageState();
}

class _AddMyVehicleDetailsStepPageState
    extends State<AddMyVehicleDetailsStepPage> {
  // void _nextButtonFunction(BuildContext context) {
  //   FocusScope.of(context).unfocus();
  //   if (BlocProvider.of<AddMyVehicleCubit>(context).isUserInfoValid()) {
  //     context.go(Routes.homeRoute);
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<AddMyVehicleCubit>(context);
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                kToolbarHeight -
                AppSizes.s30.r,
            child: PageContentPadding(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        _headLineWidget(),
                        _vehicleDetails(context),
                      ],
                    ),
                    PrimaryButton.fullWidth(
                      child: Text(AppStrings.next.tr().toUpperCase()),
                    ),
                  ]),
            ),
          ),
        ));
  }

  Widget _headLineWidget() {
    return Column(
      children: [
        Image.asset(ImageAssets.addMyVehicleStep2, width: AppSizes.s150.r),
        CustomSpacers.large(),
        Column(
          children: [
            Text(
              AppStrings.vehicleDetails.tr(),
              style: mediumHeadlineStyle(),
            ),
            CustomSpacers.medium(),
            Text(
              AppStrings.vehicleDetailsDescription.tr(),
              style: bodyStyle(),
            ),
          ],
        ),
        CustomSpacers.extraLarge(),
      ],
    );
  }

  Widget _vehicleDetails(BuildContext context) {
    final cubit = BlocProvider.of<AddMyVehicleCubit>(context);
    return Form(
      // Todo: Add onChanged to check if the form is empty
      key: cubit.vehicleDetailsForm,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomTextFormField(
          hintText: AppStrings.vehicleType.tr(),
          controller: cubit.vehicleTypeController,
        ),
        CustomSpacers.medium(),
        CustomTextFormField(
          hintText: AppStrings.vehicleBrand.tr(),
          controller: cubit.vehicleBrandController,
        ),
        CustomSpacers.medium(),
        CustomTextFormField(
          hintText: AppStrings.vehicleModel.tr(),
          controller: cubit.vehicleModelController,
        ),
        CustomSpacers.medium(),
        CustomTextFormField(
          hintText: AppStrings.vehicleCountry.tr(),
          controller: cubit.vehicleCountryController,
        ),
        CustomSpacers.medium(),
        CustomTextFormField(
          hintText: AppStrings.vehicleYear.tr(),
          controller: cubit.vehicleYearController,
        ),
      ]),
    );
  }
}
