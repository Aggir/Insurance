import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/blocs/home/home_cubit.dart';
import 'package:insurance_app/presentation/blocs/my_vehicles/my_vehicles_cubit.dart';
import 'package:insurance_app/presentation/blocs/notifications/notifications_cubit.dart';

import 'package:insurance_app/presentation/screens/home/components/ads_slider.dart';
import 'package:insurance_app/presentation/screens/home/components/first_login_dialog.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/font_manager.dart';
import 'package:insurance_app/presentation/theme/styles_manager.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';

import '../../../../app/router/routes.dart';
import '../../../blocs/user/user_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.dialog, super.key});
  final Widget? dialog;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _notificationButtonFunction(BuildContext context) {
    context.push(AppScreen.notifications.toPath);
  }

  _createVehicleFunction(BuildContext context) {
    context.go(AppScreen.addMyVehicle.toPath);
  }

  _carsInsuranceFunction(BuildContext context) {
    context.go(AppScreen.vehiclesInsurance.toPath);
  }

  @override
  void initState() {
    super.initState();
    if (BlocProvider.of<UserCubit>(context).state.isFirstLogin) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) async {
          await DialogService.load(
            context,
            content: const FirstLoginDialog(),
          );
        },
      );
    }
    if (widget.dialog != null) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) => DialogService.load(
          context,
          content: widget.dialog!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> adsUrls = [
      ImageAssets.adOne,
      ImageAssets.adTwo,
      ImageAssets.adThree
    ];

    return SafeArea(
      child: Scaffold(
        appBar: _customAppBar(context),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: AppValues.medium).r,
          physics: const ScrollPhysics(),
          children: [
            ADsSlider(adsUrls),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
              child: Column(
                children: [
                  CustomSpacers.mediumLarge(),
                  const CustomDivider(),
                  CustomSpacers.mediumLarge(),
                  BlocBuilder<MyVehiclesCubit, MyVehiclesState>(
                    builder: (context, state) {
                      if (state.fetchMyVehiclesStatus.isSuccess &&
                          (state.myVehicles == null ||
                              state.myVehicles!.isEmpty)) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _createVehicleFirstWidget(context),
                            CustomSpacers.mediumLarge(),
                            const CustomDivider(),
                            CustomSpacers.mediumLarge(),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                  _insuranceServicesSection(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  PreferredSize _customAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, AppSizes.s72.r),
      child: Container(
        // color: AppColors.danger,
        padding: const EdgeInsets.symmetric(
          vertical: AppValues.small,
          horizontal: AppValues.small,
        ).r,
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: AppSizes.s48.r,
                      width: AppSizes.s48.r,
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
                    CustomSpacers.medium(),
                    Text(
                      '${AppStrings.welcome.tr()}${state.user?.firstName}!',
                      style: mediumSmallHeadlineStyle(),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => _notificationButtonFunction(context),
                  icon: Stack(children: [
                    SvgPicture.asset(
                      SvgAssets.bell,
                      height: AppSizes.s32.r,
                      width: AppSizes.s32.r,
                    ),
                    BlocBuilder<NotificationsCubit, NotificationsState>(
                      builder: (context, state) {
                        if (state.countUnseen > 0) {
                          return Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: AppSizes.s8.r,
                              backgroundColor: AppColors.danger,
                              child: Center(
                                child: Text(
                                  state.countUnseen > 9
                                      ? '9+'
                                      : state.countUnseen.toString(),
                                  textAlign: TextAlign.center,
                                  style: boldExtraSmallWhiteStyle(),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _insuranceServicesSection(BuildContext context) {
    final List<Map<String, String>> insuranceServices = [
      {
        'svgPath': SvgAssets.flame,
        'title': AppStrings.fireInsurance.tr(),
      },
      {
        'svgPath': SvgAssets.airplane,
        'title': AppStrings.travelersInsurance.tr(),
      },
      {
        'svgPath': SvgAssets.briefcase,
        'title': AppStrings.propertiesInsurance.tr(),
      },
      {
        'svgPath': SvgAssets.pills,
        'title': AppStrings.healthInsurance.tr(),
      },
      {
        'svgPath': SvgAssets.personSquareStack,
        'title': AppStrings.familyInsurance.tr(),
      },
      {
        'svgPath': SvgAssets.creditCardFilled,
        'title': AppStrings.cardInsurance.tr(),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.insuranceServices.tr(),
          style: smallHeadlineStyle(),
        ),
        CustomSpacers.medium(),
        _vehicleInsuranceCard(context),
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
              insuranceServices[index]['title']!),
        )
      ],
    );
  }

  Widget _vehicleInsuranceCard(BuildContext context) {
    // Todo: Edit this widget incase if the app changed to English language or any other ltr language
    final BorderRadius borderRadius =
        BorderRadius.circular(AppValues.largeRadius.r);
    return Stack(children: [
      Container(
        width: double.infinity,
        height: AppSizes.s150.r,
        decoration: BoxDecoration(
          boxShadow: [AppValues.boxShadow],
          borderRadius: borderRadius,
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          ImageAssets.vehicleInsurance,
          fit: BoxFit.fitWidth,
        ),
      ),
      Positioned(
        top: AppValues.large.r,
        right: AppValues.small.r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.vehiclesInsurance.tr(),
              style: largeHeadlineStyle(),
            ),
            CustomSpacers.medium(),
            Container(
              padding: const EdgeInsets.all(AppValues.small).r,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
              ),
              child: Row(
                children: [
                  BlocConsumer<HomeCubit, HomeState>(
                    listener: (context, state) {
                      if (state.fetchCompaniesCountStatus.isFailure) {
                        SnackBars.error(
                            context, state.fetchCompaniesCountErrorMessage!);
                      }
                    },
                    builder: (context, state) {
                      if (!state.fetchCompaniesCountStatus.isFailure &&
                          state.companiesCount == null) {
                        return SizedBox(
                          width: AppSizes.s10.r,
                          height: AppSizes.s10.r,
                          child: CircularProgressIndicator(
                            strokeWidth: AppSizes.s2.r,
                          ),
                        );
                      }
                      return Text(
                        '${state.companiesCount ?? 0}',
                        style: getExtraBoldStyle(
                            color: AppColors.primary, fontSize: FontSize.s14),
                      );
                    },
                  ),
                  Text(' ${AppStrings.company.tr()}', style: primaryBodyStyle())
                ],
              ),
            )
          ],
        ),
      ),
      Positioned.fill(
        child: Material(
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _carsInsuranceFunction(context),
          ),
        ),
      ),
    ]);
  }

  Widget _createVehicleFirstWidget(BuildContext context) {
    final BorderRadius borderRadius =
        BorderRadius.circular(AppValues.largeRadius.r);
    return BlocBuilder<MyVehiclesCubit, MyVehiclesState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(AppValues.mediumSmall).r,
              decoration: BoxDecoration(
                boxShadow: [AppValues.boxShadow],
                borderRadius: borderRadius,
                color: AppColors.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: borderRadius),
                    child: ClipRRect(
                      child: Image.asset(ImageAssets.newVehicleFile),
                    ),
                  ),
                  Text(
                    AppStrings.createVehicleFileFirst.tr(),
                    style: smallHeadlineStyle()
                        .copyWith(color: AppColors.whiteText),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppValues.mediumRadius.r),
                          color: AppColors.black.withOpacity(0.14)),
                      padding: const EdgeInsets.symmetric(
                              horizontal: AppValues.small,
                              vertical: AppValues.medium)
                          .r,
                      child: SvgPicture.asset(
                        SvgAssets.chevronLeft,
                        height: AppSizes.s22.r,
                        width: AppSizes.s22.r,
                      )),
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                borderRadius: borderRadius,
                clipBehavior: Clip.antiAlias,
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _createVehicleFunction(context),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _insuranceServiceGridItem(
    String svgPath,
    String title,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        boxShadow: [AppValues.innerShadow],
        borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgPath,
            height: AppSizes.s28.r,
            width: AppSizes.s28.r,
          ),
          CustomSpacers.extraSmall(),
          Text(
            title,
            style: smallGrayBodyStyle(),
          ),
          CustomSpacers.extraSmall(),
          Text(
            AppStrings.soon.tr(),
            style: smallGrayBodyStyle(),
          )
        ],
      ),
    );
  }
}
