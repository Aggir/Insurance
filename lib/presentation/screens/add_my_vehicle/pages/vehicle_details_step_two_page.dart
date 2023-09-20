import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/blocs/add_my_vehicle/add_my_vehicle_cubit.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/cupertino_switch_tile.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/custom_text_form_field.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import '../../../theme/app_colors.dart';

class AddMyVehicleDetailsStepTwoPage extends StatefulWidget {
  const AddMyVehicleDetailsStepTwoPage({super.key});

  @override
  State<AddMyVehicleDetailsStepTwoPage> createState() =>
      _AddMyVehicleDetailsStepTwoPageState();
}

class _AddMyVehicleDetailsStepTwoPageState
    extends State<AddMyVehicleDetailsStepTwoPage> {
  void _nextButtonFunction(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (BlocProvider.of<AddMyVehicleCubit>(context)
        .isVehicleDetailsFormTwoValid()) {
      context.go(AppScreen.addMyVehiclePictureStep.toPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: constraints.copyWith(
              minHeight: constraints.maxHeight,
              maxHeight: double.infinity,
            ),
            child: PageContentPadding(
              child: IntrinsicHeight(
                child: Column(children: [
                  Container(
                    height: AppSizes.s104.r,
                    width: AppSizes.s104.r,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                        image: AssetImage(ImageAssets.addMyVehicleStep2),
                      ),
                    ),
                  ),
                  CustomSpacers.mediumLarge(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.vehicleDetails.tr(),
                        style: largeHeadlineStyle(),
                      ),
                      Text(
                        ' (2/2)',
                        style: largeHeadlineStyle()
                            .copyWith(color: AppColors.primary),
                      )
                    ],
                  ),
                  CustomSpacers.medium(),
                  Text(
                    AppStrings.vehicleDetailsDescription.tr(),
                    style: bodyStyle(),
                  ),
                  CustomSpacers.extraLarge(),
                  _form(context),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: PrimaryButton.fullWidth(
                        onPressed: () => _nextButtonFunction(context),
                        child: Text(AppStrings.next.tr().toUpperCase()),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _form(BuildContext context) {
    final cubit = BlocProvider.of<AddMyVehicleCubit>(context);
    return Form(
      // Todo: Add onChanged to check if the form is empty
      key: cubit.vehicleDetailsTwoForm,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        BlocBuilder<AddMyVehicleCubit, AddMyVehicleState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.selectedVehicleTypeId == 1) ...[
                  CustomTextFormField(
                    controller: cubit.vehicleHorsePowerController,
                    hintText: AppStrings.horsepower.tr(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value != null && value.isNotEmpty) {
                        int.parse(value) > 80
                            ? cubit.vehicleHorsePowerController.text = '80'
                            : null;
                      }
                    },
                  ),
                  CustomSpacers.medium(),
                ],
                if ((state.selectedVehicleTypeId ?? 0) >= 1 &&
                    (state.selectedVehicleTypeId ?? 0) <= 5) ...[
                  CustomTextFormField(
                    controller: cubit.vehicleMaxPassengerController,
                    hintText: AppStrings.maxPassengers.tr(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value != null && value.isNotEmpty) {
                        int.parse(value) > 100
                            ? cubit.vehicleMaxPassengerController.text = '100'
                            : null;
                      }
                    },
                  ),
                  if (state.selectedVehicleTypeId != 1) CustomSpacers.medium(),
                ],
                if (state.selectedVehicleTypeId == 5 ||
                    state.selectedVehicleTypeId == 8) ...[
                  CustomTextFormField(
                    controller: cubit.vehicleWeightController,
                    hintText: AppStrings.weight.tr(),
                    keyboardType: TextInputType.number,
                    acceptsDot: true,
                  ),
                  CustomSpacers.medium(),
                ],
                if (state.selectedVehicleTypeId == 1 ||
                    state.selectedVehicleTypeId == 9) ...[
                  CupertinoSwitchTile(
                      value: state.selectedVehicleWithAttachment ?? false,
                      onTap: (_) => cubit.toggleVehicleWithAttachment(),
                      text: AppStrings.withAttachment.tr()),
                ],
              ],
            );
          },
        ),
        CustomTextFormField(
          controller: cubit.vehicleEngineNumberController,
          hintText: AppStrings.engineSerialNumber.tr(),
        ),
        CustomSpacers.medium(),
        CustomTextFormField(
          controller: cubit.vehicleChassisNumberController,
          hintText: AppStrings.chassisNumber.tr(),
        ),
        CustomSpacers.medium(),
        CustomTextFormField(
          controller: cubit.vehicleColorNameController,
          hintText: AppStrings.vehicleColorName.tr(),
        ),
        CustomSpacers.small(),
        Text(
          AppStrings.pleaseMakeSureThatTheEnteredInfo.tr(),
          style: smallGrayBodyStyle(),
        ),
        CustomSpacers.small(),
      ]),
    );
  }
}
