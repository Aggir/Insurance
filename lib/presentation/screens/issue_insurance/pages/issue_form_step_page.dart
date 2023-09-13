import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/enums/status_enum.dart';

import 'package:insurance_app/presentation/blocs/issue_insurance/issue_insurance_cubit.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_drop_down_field.dart';
import 'package:insurance_app/presentation/widgets/custom_form_field_date_picker.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/presentation/widgets/snackbars.dart';

import '../../../../app/assets_manager.dart';
import '../../../../app/router/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/page_content_padding.dart';

class IssueFormStepPage extends StatelessWidget {
  const IssueFormStepPage({super.key});

  void _nextButton(BuildContext context) {
    final cubit = BlocProvider.of<IssueInsuranceCubit>(context);
    if (cubit.confirmStepOne()) {
      DialogService.loadLoadingDialog(context);
      cubit.calculateInsurancePrice();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: constraints.copyWith(
              minHeight: constraints.maxHeight,
              maxHeight: double.infinity,
            ),
            child: BlocListener<IssueInsuranceCubit, IssueInsuranceState>(
              listenWhen: (previous, current) =>
                  previous.calculateInsurancePriceStatus !=
                  current.calculateInsurancePriceStatus,
              listener: (context, state) {
                if (state.calculateInsurancePriceStatus.isFailure) {
                  DialogService.dispose();
                  SnackBars.error(
                      context, state.calculateInsurancePriceErrorMessage!);
                } else if (state.calculateInsurancePriceStatus.isSuccess) {
                  DialogService.dispose();
                  context.go(AppScreen.issueInstallmentDetails.toPath);
                }
              },
              child: PageContentPadding(
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: AppSizes.s104.r,
                        width: AppSizes.s104.r,
                        decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(100),
                            image: const DecorationImage(
                                image: AssetImage(ImageAssets.issuing))),
                      ),
                      CustomSpacers.mediumLarge(),
                      Text(
                        AppStrings.carsInsurancePolicy.tr(),
                        style: largeHeadlineStyle(),
                        textAlign: TextAlign.center,
                      ),
                      CustomSpacers.medium(),
                      Text(
                        AppStrings.carsInsurancePolicyDescription.tr(),
                        style: darkGrayBodyStyle(),
                        textAlign: TextAlign.center,
                      ),
                      CustomSpacers.extraLarge(),
                      _formWidget(context),
                      const Spacer(),
                      CustomSpacers.medium(),
                      PrimaryButton.fullWidth(
                        onPressed: () => _nextButton(context),
                        child: Text(AppStrings.next.tr()),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formWidget(BuildContext context) {
    final cubit = BlocProvider.of<IssueInsuranceCubit>(context);
    return Form(
        key: cubit.formKey,
        child: BlocBuilder<IssueInsuranceCubit, IssueInsuranceState>(
          builder: (context, state) {
            return Column(
              children: [
                CustomDropDownField(
                  onChanged: (value) {
                    cubit.setSelectedCompany(int.parse(value));
                  },
                  hintText: AppStrings.selectTheInsuranceCompany.tr(),
                  items: state.insuranceFormData == null
                      ? []
                      : state.insuranceFormData!.companies
                          .map(
                            (company) => DropdownMenuItem(
                              value: company.id.toString(),
                              child: Text(
                                company.name,
                                style: bodyStyle(),
                              ),
                            ),
                          )
                          .toList(),
                ),
                CustomSpacers.medium(),
                CustomDropDownField(
                  onChanged: (value) {
                    cubit.setSelectedType(int.parse(value));
                  },
                  hintText: AppStrings.selectInsuranceType.tr(),
                  items: state.insuranceFormData == null
                      ? []
                      : state.insuranceFormData!.insuranceTypes
                          .map(
                            (type) => DropdownMenuItem(
                              value: type.id.toString(),
                              child: Text(
                                type.name,
                                style: bodyStyle(),
                              ),
                            ),
                          )
                          .toList(),
                ),
                CustomSpacers.medium(),
                CustomDropDownField(
                  onChanged: (value) {
                    cubit.setSelectedVehicle(int.parse(value));
                  },
                  hintText: AppStrings.selectTheVehicle.tr(),
                  disabledHint: state.fetchInsuranceFormDataStatus.isSuccess
                      ? AppStrings.youDoNotHaveAnyUninsuredVehicles.tr()
                      : null,
                  items: state.insuranceFormData == null
                      ? []
                      : state.insuranceFormData!.vehicles
                          .where((vehicle) => vehicle.insurance == null)
                          .map(
                            (type) => DropdownMenuItem(
                              value: type.id.toString(),
                              child: Row(
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.all(AppSizes.s2).r,
                                    height: AppSizes.s40.r,
                                    width: AppSizes.s40.r,
                                    decoration: BoxDecoration(
                                        color: AppColors.lightest,
                                        border: Border.all(
                                            color: AppColors.lightGray),
                                        borderRadius: BorderRadius.circular(
                                            AppValues.smallRadius.r)),
                                    child: CachedNetworkImage(
                                      imageUrl: type.brand.icon,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  CustomSpacers.small(),
                                  Text(
                                    type.alias.isEmpty
                                        ? "${type.brand.name} ${type.model.name} - ${type.makingYear}"
                                        : type.alias,
                                    style: bodyStyle(),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                ),
                CustomSpacers.medium(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: CustomFormFieldDatePicker(
                      onChanged: (_) {
                        cubit.setEndDate();
                      },
                      controller: cubit.startDateController,
                      hintText: AppStrings.startDate.tr(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 10),
                    )),
                    CustomSpacers.medium(),
                    Flexible(
                        child: CustomFormFieldDatePicker(
                      controller: cubit.endDateController,
                      enabled: false,
                      hintText: AppStrings.endDate.tr(),
                    )),
                  ],
                )
              ],
            );
          },
        ));
  }
}
