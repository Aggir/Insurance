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

class AboutCompanyTab extends StatelessWidget {
  const AboutCompanyTab({super.key});

  final _companyName = 'شركة تيبستي للتأمين';
  final _companyDescription =
      'شركة تيبستي للتأمين هي شركة ليبية مساهمة تأسست بموجب قرار  التأسيس المؤرخ 13/يناير/2011 وبرأس مال قدره 10,000,000 دينار ليبي،  وخاضعة لقانون رقم 3 لسنة 2005 بشأن الإشراف والرقابة على نشاط  التأمين و مسجلة بالسجل التجاري رقم 26681.2010 ، وقد بدأت في  توفير الخدمات للزبائن مباشرة بعد الأحداث التي مرت بها البلاد. حيث تقوم شركة تيبستي للتأمين بتوفير سلسلة واسعة من الخدمات   المتخصصة في تأمين المسؤوليات، الممتلكات، الكيانات العامة،  الشركات الكوارث.';
  final _imagePath = ImageAssets.tibestyInsuranceCo;

  void _branchesButtonFunction(BuildContext context) {}

  void _pricesButtonFunction(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
              horizontal: AppValues.medium, vertical: AppValues.large)
          .r,
      child: Column(
        children: [
          Container(
            height: AppSizes.s64.r,
            width: AppSizes.s64.r,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
              border: Border.all(color: AppColors.grayLight),
            ),
            child: Image.asset(
              _imagePath,
              height: AppSizes.s64.r,
              width: AppSizes.s64.r,
            ),
          ),
          CustomSpacers.medium(),
          Text(
            _companyName,
            style: mediumSmallHeadlineStyle(),
          ),
          CustomSpacers.large(),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.aboutTheCompany.tr(),
                  style: extraSmallHeadlineStyle(),
                ),
                CustomSpacers.medium(),
                Text(
                  _companyDescription,
                  style: smallDarkGrayBodyStyle(),
                ),
              ],
            ),
          ),
          CustomSpacers.extraLarge(),
          _customListTile(
            imgPath: ImageAssets.location,
            title: AppStrings.branches.tr(),
            onTap: () => _branchesButtonFunction(context),
          ),
          CustomSpacers.medium(),
          _customListTile(
            imgPath: ImageAssets.price,
            title: AppStrings.prices.tr(),
            onTap: () => _pricesButtonFunction(context),
          ),
        ],
      ),
    );
  }

  Widget _customListTile(
      {required String imgPath,
      required String title,
      void Function()? onTap}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
        boxShadow: [AppValues.boxShadow],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppValues.medium).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryLightest,
                        borderRadius: BorderRadius.circular(AppValues.small.r),
                      ),
                      child: Image.asset(
                        imgPath,
                        height: AppSizes.s40.r,
                        width: AppSizes.s40.r,
                      ),
                    ),
                    CustomSpacers.mediumLarge(),
                    Text(
                      title,
                      style: smallHeadlineStyle(),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  SvgAssets.chevronLeft,
                  height: AppSizes.s22.r,
                  width: AppSizes.s22.r,
                  colorFilter:
                      ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
