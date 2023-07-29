import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/blocs/issue_insurance/issue_insurance_cubit.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_drop_down_field.dart';
import 'package:insurance_app/presentation/widgets/custom_form_field_date_picker.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;

import '../../../../app/assets_manager.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/page_content_padding.dart';

class IssueFormStepPage extends StatelessWidget {
  const IssueFormStepPage({super.key});

  void _nextButton(BuildContext context) {
    if (BlocProvider.of<IssueInsuranceCubit>(context).confirmStepOne()) {
      context.go(Routes.issueInstallmentDetailsRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              AppValues.appBarHeight.r -
              AppSizes.s30.r,
          child: PageContentPadding(
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
                PrimaryButton.fullWidth(
                  onPressed: () => _nextButton(context),
                  child: Text(AppStrings.next.tr()),
                )
              ],
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
        child: Column(
          children: [
            CustomDropDownField(
              onChanged: (value) {
                cubit.setSelectedCompany(value);
              },
              hintText: AppStrings.selectTheInsuranceCompany.tr(),
              items: DUMMY.insuranceCompanies
                  .map(
                    (company) => DropdownMenuItem(
                      value: company['value'],
                      child: Text(
                        company['value'] ?? '',
                        style: bodyStyle(),
                      ),
                    ),
                  )
                  .toList(),
            ),
            CustomSpacers.medium(),
            CustomDropDownField(
              onChanged: (value) {
                cubit.setSelectedType(value);
              },
              hintText: AppStrings.selectInsuranceType.tr(),
              items: DUMMY.typesOfCarInsurance
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
              onChanged: (value) {
                cubit.setSelectedVehicle(value);
              },
              hintText: AppStrings.selectTheVehicle.tr(),
              items: DUMMY.myVehicles
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
                                borderRadius: BorderRadius.circular(
                                    AppValues.smallRadius.r)),
                            child: Image.asset(
                              type['imgPath'] ?? ImageAssets.image,
                              fit: BoxFit.fitWidth,
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
        ));
  }
}
