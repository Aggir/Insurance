import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/blocs/add_my_vehicle/add_my_vehicle_cubit.dart';
import 'package:insurance_app/presentation/screens/add_my_vehicle/components/car_brand_modal.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_drop_down_field.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;

import '../../../theme/app_colors.dart';

class AddMyVehicleDetailsStepOnePage extends StatefulWidget {
  const AddMyVehicleDetailsStepOnePage({super.key});

  @override
  State<AddMyVehicleDetailsStepOnePage> createState() =>
      _AddMyVehicleDetailsStepOnePageState();
}

class _AddMyVehicleDetailsStepOnePageState
    extends State<AddMyVehicleDetailsStepOnePage> {
  void _nextButtonFunction(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (BlocProvider.of<AddMyVehicleCubit>(context)
        .isVehicleDetailsFormOneValid()) {
      context.go(AppScreen.addMyVehicleDetailsStepTwo.toPath);
    }
  }

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
                        ' (2/1)',
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
      key: cubit.vehicleDetailsOneForm,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomDropDownField(
          hintText: AppStrings.vehicleType.tr(),
          items: DUMMY.test
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
        _carBrandField(),
        CustomSpacers.medium(),
        CustomDropDownField(
          hintText: AppStrings.vehicleModel.tr(),
          items: DUMMY.test
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
          hintText: AppStrings.vehicleCountry.tr(),
          items: DUMMY.vehicleCountry
              .map(
                (type) => DropdownMenuItem(
                  value: type['value'],
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSizes.s2).r,
                        height: AppSizes.s40.r,
                        width: AppSizes.s40.r,
                        decoration: BoxDecoration(
                            color: AppColors.lightest,
                            border: Border.all(color: AppColors.lightGray),
                            borderRadius:
                                BorderRadius.circular(AppValues.smallRadius.r)),
                        child: SvgPicture.asset(
                          type['svgPath'] ?? ImageAssets.image,
                          // fit: BoxFit.fitHeight,
                        ),
                      ),
                      CustomSpacers.small(),
                      Text(
                        type['value'] ?? '',
                        style: bodyStyle(),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        CustomSpacers.medium(),
        CustomDropDownField(
          hintText: AppStrings.vehicleYear.tr(),
          items: DUMMY.vehicleYears
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

  // Widget _carBrandField2() {
  //   return BlocBuilder<AddMyVehicleCubit, AddMyVehicleState>(
  //     builder: (context, state) {
  //       return Stack(
  //         children: [
  //           CustomDropDownField(
  //             value: '',
  //             hintText: AppStrings.selectTheVehicle.tr(),
  //             items: DUMMY.myVehicles
  //                 .map(
  //                   (type) => DropdownMenuItem(
  //                     value: type['value'],
  //                     child: Row(
  //                       children: [
  //                         Container(
  //                           padding: const EdgeInsets.all(AppSizes.s2).r,
  //                           height: AppSizes.s40.r,
  //                           width: AppSizes.s40.r,
  //                           decoration: BoxDecoration(
  //                               color: AppColors.lightest,
  //                               border: Border.all(color: AppColors.lightGray),
  //                               borderRadius: BorderRadius.circular(
  //                                   AppValues.smallRadius.r)),
  //                           child: Image.asset(
  //                             type['imgPath'] ?? ImageAssets.image,
  //                             fit: BoxFit.fitWidth,
  //                           ),
  //                         ),
  //                         CustomSpacers.small(),
  //                         Text(
  //                           type['value'] ?? '',
  //                           style: bodyStyle(),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //                 .toList(),
  //           ),
  //           Positioned.fill(child: InkWell(
  //             onTap: () {
  //               showModalBottomSheet(
  //                 context: context,
  //                 // isScrollControlled: true,
  //                 shape: AppValues.modalShape,
  //                 builder: (context) => const CarBrandModal(),
  //               );
  //             },
  //           ))
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _carBrandField() {
    return Container(
      color: AppColors.white,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            // isScrollControlled: true,
            shape: AppValues.modalShape,
            builder: (context) => const CarBrandModal(),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
                  vertical: AppValues.small, horizontal: AppValues.small)
              .r,
          height: AppValues.textFieldHeight.r,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grayLight),
            borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
          ),
          child: BlocBuilder<AddMyVehicleCubit, AddMyVehicleState>(
            builder: (context, state) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (state.carBrand == null)
                      Text(
                        AppStrings.selectTheVehicle.tr(),
                        style: grayBodyStyle(),
                      ),
                    if (state.carBrand != null)
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSizes.s2).r,
                            height: AppSizes.s40.r,
                            width: AppSizes.s40.r,
                            decoration: BoxDecoration(
                                color: AppColors.lightest,
                                border: Border.all(color: AppColors.lightGray),
                                borderRadius: BorderRadius.circular(
                                    AppValues.smallRadius.r)),
                            child: Image.asset(
                              state.carBrand!['imgPath'] ?? ImageAssets.image,
                            ),
                          ),
                          CustomSpacers.small(),
                          Text(
                            state.carBrand!['value'] ?? '',
                            style: bodyStyle(),
                          ),
                        ],
                      ),
                    SvgPicture.asset(SvgAssets.chevronBottom)
                  ]);
            },
          ),
        ),
      ),
    );
  }
}
