import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';

import '../../../app/assets_manager.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_text_form_field.dart';

class InsuranceCompaniesScreen extends StatelessWidget {
  const InsuranceCompaniesScreen({super.key});
  final _companyName = 'شركة تيبستي للتأمين';
  final _companyDescription =
      'هي شركة ليبية مساهمة تأسست بموجب قرار التأسيس المؤرخ 13\يناير\2011 وبرأس مال قدره 10,000,000 دينار';
  final _imagePath = ImageAssets.tibestyInsuranceCo;

  void _issueAnInsuranceFunction(BuildContext context) {
    context.go(Routes.issueInsuranceRoute);
  }

  @override
  Widget build(BuildContext context) {
    final searchFocusNode = FocusNode();
    return GestureDetector(
      onTap: () {
        searchFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar.basic(
          title: AppStrings.insurancePolicyPrices.tr(),
          backButton: () {
            context.go(Routes.carsInsuranceRoute);
          },
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppValues.medium).r,
              child: CustomTextFormField(
                focusNode: searchFocusNode,
                hintText: AppStrings.search.tr(),
                prefixIcon: SvgPicture.asset(
                  SvgAssets.search,
                  height: AppSizes.s24.r,
                  width: AppSizes.s24.r,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                // shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(AppValues.medium).r,
                children: List.generate(
                  5,
                  (index) => Column(
                    children: [
                      _companyCardWidget(
                        searchFocusNode,
                        context,
                        name: _companyName,
                        imagePath: _imagePath,
                        description: _companyDescription,
                      ),
                      CustomSpacers.medium(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _companyCardWidget(
    FocusNode focusNode,
    BuildContext context, {
    required String name,
    required String description,
    required String imagePath,
  }) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
                  vertical: AppValues.medium, horizontal: AppValues.medium)
              .r,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
              color: AppColors.white,
              boxShadow: [AppValues.boxShadow]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(AppValues.mediumRadius.r),
                          border: Border.all(color: AppColors.grayLight),
                        ),
                        child: Image.asset(
                          imagePath,
                          height: AppSizes.s64.r,
                          width: AppSizes.s64.r,
                        ),
                      ),
                      CustomSpacers.medium(),
                      SizedBox(
                        width: AppSizes.s200.r,
                        child: Text(
                          name,
                          style: mediumSmallHeadlineStyle(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                            vertical: AppValues.medium,
                            horizontal: AppValues.small)
                        .r,
                    decoration: BoxDecoration(
                        color: AppColors.lightest,
                        borderRadius:
                            BorderRadius.circular(AppValues.mediumRadius),
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
              CustomSpacers.medium(),
              Text(
                description,
                style: smallGrayBodyStyle(),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                focusNode.unfocus();
              },
            ),
          ),
        ),
      ],
    );
  }
}
