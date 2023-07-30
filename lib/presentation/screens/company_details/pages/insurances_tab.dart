import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';

class InsurancesTab extends StatelessWidget {
  const InsurancesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
              horizontal: AppValues.medium, vertical: AppValues.large)
          .r,
      child: Column(
        children: [
          _personalInsurances(),
          CustomSpacers.large(),
          _propertyInsurances()
        ],
      ),
    );
  }

  Widget _personalInsurances() {
    final List<Map<String, dynamic>> insuranceServices = [
      {
        'svgPath': SvgAssets.pills,
        'title': AppStrings.healthInsurance.tr(),
        'isAvailable': false,
      },
      {
        'svgPath': SvgAssets.airplane,
        'title': AppStrings.travelersInsurance.tr(),
        'isAvailable': false,
      },
      {
        'svgPath': SvgAssets.healthFilled,
        'title': AppStrings.medicalLiability.tr(),
        'isAvailable': false,
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.personalInsurances.tr(),
          style: smallHeadlineStyle(),
        ),
        CustomSpacers.medium(),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: AppValues.mediumSmall.r,
            crossAxisSpacing: AppValues.mediumSmall.r,
          ),
          itemCount: insuranceServices.length,
          itemBuilder: (context, index) => _insuranceServiceGridItem(
            insuranceServices[index]['svgPath']!,
            insuranceServices[index]['title']!,
            insuranceServices[index]['isAvailable']!,
          ),
        )
      ],
    );
  }

  Widget _propertyInsurances() {
    final List<Map<String, dynamic>> insuranceServices = [
      {
        'svgPath': SvgAssets.carFilled,
        'title': AppStrings.carsInsurance.tr(),
        'isAvailable': true,
      },
      {
        'svgPath': SvgAssets.flame,
        'title': AppStrings.fireInsurance.tr(),
        'isAvailable': false,
      },
      {
        'svgPath': SvgAssets.airplane,
        'title': AppStrings.travelersInsurance.tr(),
        'isAvailable': false,
      },
      {
        'svgPath': SvgAssets.shipFilled,
        'title': AppStrings.marineInsurance.tr(),
        'isAvailable': false,
      },
      {
        'svgPath': SvgAssets.personSquareStack,
        'title': AppStrings.familyInsurance.tr(),
        'isAvailable': false,
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.propertyInsurances.tr(),
          style: smallHeadlineStyle(),
        ),
        CustomSpacers.medium(),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: AppValues.mediumSmall.r,
            crossAxisSpacing: AppValues.mediumSmall.r,
          ),
          itemCount: insuranceServices.length,
          itemBuilder: (context, index) => _insuranceServiceGridItem(
            insuranceServices[index]['svgPath']!,
            insuranceServices[index]['title']!,
            insuranceServices[index]['isAvailable']!,
          ),
        )
      ],
    );
  }

  Widget _insuranceServiceGridItem(
      String svgPath, String title, bool isAvailable) {
    getTextStyle() {
      return isAvailable
          ? extraSmallHeadlineStyle().copyWith(color: AppColors.white)
          : smallGrayBodyStyle();
    }

    return Container(
      decoration: BoxDecoration(
          color: isAvailable ? AppColors.primary : AppColors.lightGray,
          boxShadow: [AppValues.innerShadow],
          borderRadius: BorderRadius.circular(AppValues.largeRadius.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgPath,
            height: AppSizes.s28.r,
            width: AppSizes.s28.r,
            colorFilter: isAvailable
                ? ColorFilter.mode(AppColors.white, BlendMode.srcIn)
                : null,
          ),
          CustomSpacers.extraSmall(),
          Text(
            title,
            style: getTextStyle(),
          ),
          if (!isAvailable) ...[
            CustomSpacers.extraSmall(),
            Text(
              AppStrings.soon.tr(),
              style: getTextStyle(),
            )
          ]
        ],
      ),
    );
  }
}
