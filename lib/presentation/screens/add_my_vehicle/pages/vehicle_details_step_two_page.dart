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
import 'package:insurance_app/presentation/widgets/custom_drop_down_field.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/custom_text_form_field.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;

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
      context.go(Routes.addMyVehiclePictureStepRoute);
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
        CustomDropDownField(
          hintText: AppStrings.selectTheHorsepowerOfTheEngine.tr(),
          items: DUMMY.horsePower
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
        CustomSpacers.medium(),
        CustomTextFormField(
          hintText: AppStrings.engineSerialNumber.tr(),
        ),
        CustomSpacers.medium(),
        CustomTextFormField(
          hintText: AppStrings.chassisNumber.tr(),
        ),
        CustomSpacers.medium(),
        CustomDropDownField(
          hintText: AppStrings.carColor.tr(),
          items: DUMMY.colors
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
        CustomSpacers.medium(),
        CustomDropDownField(
          hintText: AppStrings.seatsWithoutTheDriver.tr(),
          items: DUMMY.seatsNumberWithoutTheDriver
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
      ]),
    );
  }
}
