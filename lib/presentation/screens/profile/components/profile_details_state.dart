import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../../app/dummy_data.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';

class ProfileDetailsState extends StatelessWidget {
  const ProfileDetailsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _infoCardWidget(
          SvgAssets.envelope,
          AppStrings.emailAddress.tr(),
          email,
        ),
        CustomSpacers.medium(),
        _infoCardWidget(
          SvgAssets.phone,
          AppStrings.phoneNumber.tr(),
          phone,
        ),
        CustomSpacers.medium(),
        _infoCardWidget(
          SvgAssets.calendar,
          AppStrings.birthDate.tr(),
          birthDate,
        ),
        CustomSpacers.medium(),
        _infoCardWidget(
          SvgAssets.idCard,
          AppStrings.nationality.tr(),
          (isLibyan ? AppStrings.libyan : AppStrings.nonLibyan).tr(),
        ),
      ],
    );
  }

  Widget _infoCardWidget(String svgPath, String title, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppValues.mediumSmall).r,
      decoration: BoxDecoration(
        color: AppColors.lightest,
        border: Border.all(color: AppColors.grayLight),
        borderRadius:
            BorderRadius.circular(AppValues.cardPageContainerRadius.r),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.grayLight),
            ),
            child: SvgPicture.asset(
              svgPath,
              height: AppSizes.s28.r,
              width: AppSizes.s28.r,
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
          ),
          CustomSpacers.medium(),
          SizedBox(
            width: AppSizes.s270.r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: extraSmallGrayBodyStyle(),
                ),
                Text(
                  text,
                  style: smallBodyStyle(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
