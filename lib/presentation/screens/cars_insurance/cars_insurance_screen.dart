import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/blocs/compare_companies/cubit/compare_companies_cubit.dart';
import 'package:insurance_app/presentation/screens/compare_companies/components/filter_insurance_companies_modal.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';

import '../../../app/assets_manager.dart';
import '../../theme/app_colors.dart';

class CarsInsuranceScreen extends StatelessWidget {
  const CarsInsuranceScreen({super.key});

  void _issueCarInsurance(BuildContext context) {
    context.go(AppScreen.issueInsurance.toPath);
  }

  void _reminderAboutExpiration(BuildContext context) {
    context.go(AppScreen.reminder.toPath);
  }

  void _insurancePolicyPrices(BuildContext context) {
    initCompareCompaniesCubit();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: AppValues.modalShape,
      builder: (context) => BlocProvider.value(
        value: instance<CompareCompaniesCubit>(),
        child: const FilterInsuranceCompaniesModal(),
      ),
    );
  }

  void _insuranceCompanies(BuildContext context) {
    context.go(AppScreen.companies.toPath);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go(AppScreen.home.toPath);
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar.basic(
          title: AppStrings.carsInsurance.tr(),
          backButton: () => context.go(AppScreen.home.toPath),
        ),
        body: ListView(
          padding: const EdgeInsets.all(AppValues.medium).r,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
              child: Text(
                AppStrings.carInsuranceScreenDescription.tr(),
                style: smallGrayBodyStyle(),
              ),
            ),
            CustomSpacers.extraLarge(),
            _customListTile(
              context,
              title: AppStrings.issuingACarInsurance.tr(),
              description: AppStrings.issuingACarInsuranceDescription.tr(),
              imgPath: ImageAssets.issuing,
              onTap: _issueCarInsurance,
            ),
            CustomSpacers.large(),
            _customListTile(
              context,
              title: AppStrings.reminderAboutExpirationDate.tr(),
              description:
                  AppStrings.reminderAboutExpirationDateDescription.tr(),
              imgPath: ImageAssets.reminder,
              onTap: _reminderAboutExpiration,
            ),
            CustomSpacers.large(),
            _customListTile(
              context,
              title: AppStrings.insurancePolicyPrices.tr(),
              description: AppStrings.insurancePolicyPricesDescription.tr(),
              imgPath: ImageAssets.insurancePrices,
              onTap: _insurancePolicyPrices,
            ),
            CustomSpacers.large(),
            _customListTile(
              context,
              title: AppStrings.insuranceCompanies.tr(),
              description: AppStrings.insuranceCompaniesDescription.tr(),
              imgPath: ImageAssets.insuranceCompanies,
              onTap: _insuranceCompanies,
            ),
          ],
        ),
      ),
    );
  }

  Widget _customListTile(BuildContext context,
      {required String title,
      required String description,
      required String imgPath,
      void Function(BuildContext context)? onTap}) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [AppValues.boxShadow],
            borderRadius: BorderRadius.circular(
              AppValues.largeRadius.r,
            ),
          ),
          padding: const EdgeInsets.all(AppValues.medium).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryLightest,
                      borderRadius: BorderRadius.circular(
                        AppValues.largeRadius.r,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      imgPath,
                      height: AppSizes.s64.r,
                      width: AppSizes.s64.r,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  CustomSpacers.medium(),
                  SizedBox(
                    width: AppSizes.s170.r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: smallHeadlineStyle(),
                        ),
                        Text(
                          description,
                          style: smallGrayBodyStyle(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                        vertical: AppValues.medium, horizontal: AppValues.small)
                    .r,
                decoration: BoxDecoration(
                    color: AppColors.lightest,
                    borderRadius: BorderRadius.circular(AppValues.mediumRadius),
                    border: Border.all(color: AppColors.grayLight)),
                child: SvgPicture.asset(
                  SvgAssets.chevronLeft,
                  height: AppSizes.s22.r,
                  width: AppSizes.s22.r,
                  colorFilter:
                      ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            // borderRadius: borderRadius,
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap != null ? () => onTap(context) : null,
            ),
          ),
        ),
      ],
    );
  }
}
