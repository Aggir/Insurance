import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/screens/home/components/insurance_list_item.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;

class MyInsurancesPage extends StatefulWidget {
  const MyInsurancesPage({super.key});

  @override
  State<MyInsurancesPage> createState() => _MyInsurancesPageState();
}

class _MyInsurancesPageState extends State<MyInsurancesPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _currentIndex.addListener(() {
      _tabController.animateTo(int.parse(_currentIndex.value));
    });
  }

  final Map<String, String> _tabsMap = {
    '0': AppStrings.underProcessing.tr(),
    '1': AppStrings.issued.tr(),
    '2': AppStrings.notPaid.tr(),
    '3': AppStrings.expired.tr(),
  };
  final _currentIndex = ValueNotifier<String>(0.toString());
  _insuranceServicesButtonFunction(BuildContext context) {
    context.go(Routes.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              AppStrings.myInsurances.tr(),
              style: smallHeadlineStyle(),
            ),
            bottom: PreferredSize(
                preferredSize: Size(double.infinity, AppSizes.s64.r),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                              vertical: AppValues.small,
                              horizontal: AppValues.small)
                          .r,
                      child: AdvancedSegment(
                        controller: _currentIndex,
                        segments: _tabsMap,
                        backgroundColor: AppColors.white,
                        activeStyle: extraSmallHeadlineStyle(),
                        inactiveStyle: smallDarkGrayBodyStyle(),
                        sliderColor: AppColors.grayLight,
                        sliderDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppValues.primaryButtonRadius.r,
                          ),
                          color: AppColors.lightest,
                          border: Border.all(color: AppColors.lightGray),
                        ),
                        shadow: const [],
                      ),
                    ),
                    const CustomDivider()
                  ],
                ))),
        body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _underProcessing(),
              _issued(),
              _notPaid(),
              _expired(),
            ]),
      ),
    );
  }

  Widget _underProcessing() {
    if (DUMMY.underProcessingInsurances.isEmpty) {
      return _emptyState(AppStrings.underProcessing.tr());
    } else {
      return ListView();
    }
  }

  Widget _issued() {
    if (DUMMY.issuedInsurances.isEmpty) {
      return _emptyState(AppStrings.issued.tr());
    } else {
      return ListView();
    }
  }

  Widget _notPaid() {
    if (DUMMY.notPaidInsurances.isEmpty) {
      return _emptyState(AppStrings.notPaid.tr());
    } else {
      return ListView(
        children: [
          ...DUMMY.notPaidInsurances
              .map((insurance) => InsuranceListItem(insurance))
              .toList()
        ],
      );
    }
  }

  Widget _expired() {
    if (DUMMY.expiredInsurances.isEmpty) {
      return _emptyState(AppStrings.expired.tr());
    } else {
      return ListView();
    }
  }

  Widget _emptyState(String text) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppValues.large).r,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              SvgAssets.insurance,
              height: AppSizes.s160.r,
            ),
            CustomSpacers.large(),
            Text(
              AppStrings.thereAreNoInsurances.tr() + text,
              style: mediumHeadlineStyle(),
            ),
            CustomSpacers.medium(),
            Text(
              '${AppStrings.youDoNotHaveAnyInsurances.tr()}$text.',
              style: grayBodyStyle(),
            ),
            CustomSpacers.large(),
            PrimaryButton.fullWidth(
              child: Text(AppStrings.insuranceServices.tr()),
              onPressed: () => _insuranceServicesButtonFunction(context),
            ),
          ]),
        ),
      ),
    );
  }
}
