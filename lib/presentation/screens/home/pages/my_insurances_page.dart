import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

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
    '0': AppStrings.underTheProcedure.tr(),
    '1': AppStrings.outgoing.tr(),
    '2': AppStrings.unpaid.tr(),
    '3': AppStrings.expired.tr(),
  };
  final _currentIndex = ValueNotifier<String>(0.toString());
  _insuranceServicesButtonFunction(BuildContext context) {}
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
              _underTheProcedure(),
              _outgoing(),
              _unpaid(),
              _expired(),
            ]),
      ),
    );
  }

  bool underTheProcedureIsEmpty = true;
  bool outgoingIsEmpty = true;
  bool unpaidIsEmpty = true;
  bool expiredIsEmpty = true;

  Widget _underTheProcedure() {
    if (underTheProcedureIsEmpty) {
      return _emptyState(AppStrings.underTheProcedure.tr());
    } else {
      return Container();
    }
  }

  Widget _outgoing() {
    if (outgoingIsEmpty) {
      return _emptyState(AppStrings.outgoing.tr());
    } else {
      return Container();
    }
  }

  Widget _unpaid() {
    if (unpaidIsEmpty) {
      return _emptyState(AppStrings.unpaid.tr());
    } else {
      return Container();
    }
  }

  Widget _expired() {
    if (expiredIsEmpty) {
      return _emptyState(AppStrings.expired.tr());
    } else {
      return Container();
    }
  }

  Widget _emptyState(String text) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppValues.large).r,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(
            SvgAssets.insuranceEmptyState,
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
    );
  }
}
