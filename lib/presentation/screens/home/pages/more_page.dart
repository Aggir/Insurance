import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';

import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/secondary_button.dart';

import '../../../../app/router/routes.dart';
import '../../../widgets/snackBars.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  void _profileWidgetFunction(BuildContext context) {
    context.go(AppScreen.profile.toPath);
  }

  void _myPaymentsFunction(BuildContext context) {
    context.go(AppScreen.myPayments.toPath);
  }

  void _termsAndConditionsFunction(BuildContext context) {
    context.go(AppScreen.termsAndConditions.toPath, extra: true);
  }

  void _settingsFunction(BuildContext context) {
    context.go(AppScreen.settings.toPath);
  }

  void _logoutFunction(BuildContext context) {
    final cubit = BlocProvider.of<UserCubit>(context);
    DialogService.loadLoadingDialog(context);
    cubit.logout();
  }

  @override
  void initState() {
    final cubit = BlocProvider.of<UserCubit>(context);
    if (cubit.state.user?.emailVerifiedAt.isEmpty ?? true) {
      cubit.refreshUserData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go(AppScreen.home.toPath);
        return false;
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                    vertical: AppValues.large, horizontal: AppValues.medium)
                .r,
            child: Column(
              children: [
                _profileRowWidget(context),
                CustomSpacers.extraLarge(),
                Text(
                  AppStrings.moreServices.tr(),
                  style: darkGrayBodyStyle(),
                ),
                CustomSpacers.large(),
                _customListTile(
                  context,
                  imgPath: ImageAssets.myPaymentsListTile,
                  title: AppStrings.myPayments.tr(),
                  description: AppStrings.myPaymentsListTileDescription.tr(),
                  onTap: _myPaymentsFunction,
                ),
                CustomSpacers.large(),
                _customListTile(
                  context,
                  imgPath: ImageAssets.termsAndConditions,
                  title: AppStrings.termsAndConditions.tr(),
                  description:
                      AppStrings.termsAndConditionsListTileDescription.tr(),
                  onTap: _termsAndConditionsFunction,
                ),
                CustomSpacers.large(),
                _customListTile(
                  context,
                  imgPath: ImageAssets.settingsListTile,
                  title: AppStrings.settings.tr(),
                  description: AppStrings.settingsListTileDescription.tr(),
                  onTap: _settingsFunction,
                ),
                CustomSpacers.extraLarge(),
                BlocListener<UserCubit, UserState>(
                  listenWhen: (previous, current) =>
                      previous.logoutStatus != current.logoutStatus,
                  listener: (context, state) {
                    if (state.logoutStatus.isFailure) {
                      DialogService.dispose();
                      SnackBars.error(context, state.logoutErrorMessage!);
                    } else if (state.logoutStatus.isInitial) {
                      DialogService.dispose();
                    }
                  },
                  child: SecondaryButton.fullWidth(
                      onPressed: () => _logoutFunction(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            SvgAssets.logout,
                            height: AppSizes.s28.r,
                            width: AppSizes.s28.r,
                          ),
                          CustomSpacers.medium(),
                          Text(
                            AppStrings.logout.tr(),
                            style: smallHeadlineStyle()
                                .copyWith(color: AppColors.gray),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileRowWidget(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.lightest,
        boxShadow: [AppValues.boxShadow],
        borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
      ),
      child: Material(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _profileWidgetFunction(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                    vertical: AppValues.mediumSmall,
                    horizontal: AppValues.medium)
                .r,
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: AppSizes.s64.r,
                                  width: AppSizes.s64.r,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: state.user != null
                                      ? state.user!.imageUrl.isNotEmpty
                                          ? CachedNetworkImage(
                                              cacheKey: state.user?.updatedAt,
                                              imageUrl: state.user!.imageUrl,
                                              fit: BoxFit.cover,
                                            )
                                          : Center(
                                              child: Text(
                                                state.user!.firstName[0],
                                                style: boldBlackLargeStyle(),
                                              ),
                                            )
                                      : Container(),
                                ),
                                Positioned.directional(
                                  textDirection: Directionality.of(context),
                                  start: AppSizes.s2.r,
                                  bottom: AppSizes.s2.r,
                                  child: Container(
                                    height: AppSizes.s16.r,
                                    width: AppSizes.s16.r,
                                    decoration: BoxDecoration(
                                      color: (state.user?.emailVerifiedAt
                                                  .isEmpty ??
                                              true)
                                          ? AppColors.primary
                                          : AppColors.secondary,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(
                                      (state.user?.emailVerifiedAt.isEmpty ??
                                              true)
                                          ? Icons.priority_high_rounded
                                          : Icons.check,
                                      size: AppSizes.s12.r,
                                      color: AppColors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            CustomSpacers.medium(),
                            SizedBox(
                              width: AppSizes.s200.r,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.user?.firstName} ${state.user?.fatherName} ${state.user?.lastName}',
                                    style: smallHeadlineStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppStrings.userId.tr(),
                                        style: smallGrayBodyStyle(),
                                      ),
                                      Text(
                                        state.user?.uniqueId.toString() ??
                                            Constants.empty,
                                        style: extraSmallHeadlineStyle(),
                                      ),
                                    ],
                                  ),
                                  if (state.user?.emailVerifiedAt.isEmpty ??
                                      true)
                                    Text(
                                      AppStrings
                                          .yourEmailAddressHasNotBeenVerified
                                          .tr(),
                                      style: smallGrayBodyStyle()
                                          .copyWith(color: AppColors.danger),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          SvgAssets.chevronLeft,
                          height: AppSizes.s22.r,
                          width: AppSizes.s22.r,
                          colorFilter:
                              ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _customListTile(BuildContext context,
      {required String title,
      required String description,
      required String imgPath,
      void Function(BuildContext context)? onTap}) {
    return InkWell(
      onTap: onTap != null ? () => onTap(context) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
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
                    height: AppSizes.s100.r,
                    width: AppSizes.s84.r,
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
                colorFilter: ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
