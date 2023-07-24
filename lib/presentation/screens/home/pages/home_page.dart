import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/screens/home/components/ads_slider.dart';
import 'package:insurance_app/presentation/screens/home/components/first_login_dialog.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/font_manager.dart';
import 'package:insurance_app/presentation/theme/styles_manager.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _notificationButtonFunction(BuildContext context) {}

  _createVehicleFunction(BuildContext context) {}

  _insureCarFunction(BuildContext context) {}

  final bool _firstLogin = true;

  @override
  void initState() {
    super.initState();
    if (_firstLogin) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) => DialogService.load(
          context,
          content: const FirstLoginDialog(),
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
    const bool showCreateVehicle = true;
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
                  const Divider(),
                  CustomSpacers.mediumLarge(),
                  if (showCreateVehicle) ...[
                    _createVehicleFirstWidget(context),
                    CustomSpacers.mediumLarge(),
                    const Divider(),
                    CustomSpacers.mediumLarge(),
                  ],
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryLight,
                  radius: AppSizes.s24.r,
                  child: Image.asset(ImageAssets.profilePicture),
                ),
                CustomSpacers.medium(),
                Text(
                  '${AppStrings.welcome.tr()}مرام!',
                  style: mediumSmallHeadlineStyle(),
                ),
              ],
            ),
            IconButton(
              onPressed: () => _notificationButtonFunction(context),
              icon: SvgPicture.asset(SvgAssets.bell),
            ),
          ],
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
        'svgPath': SvgAssets.creditCard,
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
    int companies = 32;
    // Todo: Edit this widget incase if the app changed to English language or any other ltr language
    final BorderRadius borderRadius =
        BorderRadius.circular(AppValues.cardPageContainerRadius.r);
    return Stack(children: [
      Container(
        width: double.infinity,
        height: AppSizes.s150.r,
        decoration: BoxDecoration(
          boxShadow: [AppValues.boxShadow],
          borderRadius: borderRadius,
          image: const DecorationImage(
            image: AssetImage(ImageAssets.vehicleInsurance),
          ),
        ),
      ),
      Positioned(
        top: AppValues.large.r,
        right: AppValues.small.r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.carsInsurance.tr(),
              style: largeHeadlineStyle(),
            ),
            CustomSpacers.medium(),
            Container(
              padding: const EdgeInsets.all(AppValues.small).r,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius:
                    BorderRadius.circular(AppValues.primaryButtonRadius.r),
              ),
              child: Row(
                children: [
                  Text('$companies ',
                      style: getExtraBoldStyle(
                          color: AppColors.primary, fontSize: FontSize.s14)),
                  Text(AppStrings.company.tr(), style: primaryBodyStyle())
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
            onTap: () => _insureCarFunction(context),
          ),
        ),
      ),
    ]);
  }

  Widget _createVehicleFirstWidget(BuildContext context) {
    final BorderRadius borderRadius =
        BorderRadius.circular(AppValues.cardPageContainerRadius.r);
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
                    color: AppColors.primaryLight, borderRadius: borderRadius),
                child: ClipRRect(
                  child: Image.asset(ImageAssets.newVehicleFile),
                ),
              ),
              Text(
                AppStrings.createVehicleFileFirst.tr(),
                style:
                    smallHeadlineStyle().copyWith(color: AppColors.whiteText),
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          AppValues.primaryButtonRadius.r),
                      color: AppColors.black.withOpacity(0.14)),
                  padding: const EdgeInsets.symmetric(
                          horizontal: AppValues.small,
                          vertical: AppValues.medium)
                      .r,
                  child: SvgPicture.asset(SvgAssets.chevronLeft)),
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
  }

  Widget _insuranceServiceGridItem(
    String svgPath,
    String title,
  ) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightGray,
          boxShadow: [AppValues.innerShadow],
          borderRadius:
              BorderRadius.circular(AppValues.cardPageContainerRadius.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(svgPath),
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
