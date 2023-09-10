import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/domain/entities/company.dart';
import 'package:insurance_app/presentation/blocs/companies/companies_cubit.dart';
import 'package:insurance_app/presentation/screens/company_details/components/prices_modal.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../../app/router/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';

class AboutCompanyTab extends StatelessWidget {
  const AboutCompanyTab(this.company, {super.key});
  final CompanyEntity? company;

  void _branchesButtonFunction(BuildContext context) {
    context.go(
        '${AppScreen.companyDetails.toPath}${company?.id}/${AppScreen.companyBranches.toSubPath}');
  }

  void _pricesButtonFunction(BuildContext context) {
    BlocProvider.of<CompaniesCubit>(context).clearPricesFilter();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: AppValues.modalShape,
      builder: (context) => const PricesModal(),
    );
  }

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
            child: company == null
                ? Container()
                : CachedNetworkImage(
                    imageUrl: company!.photo,
                    height: AppSizes.s64.r,
                    width: AppSizes.s64.r,
                  ),
          ),
          CustomSpacers.medium(),
          Text(
            company?.name ?? '',
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
                  company?.description ?? '',
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
