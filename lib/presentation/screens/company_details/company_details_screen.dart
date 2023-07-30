import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/presentation/screens/company_details/pages/about_company_tab.dart';
import 'package:insurance_app/presentation/screens/company_details/pages/insurances_tab.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../theme/text_style_manager.dart';
import '../../widgets/custom_divider.dart';

class CompanyDetailsScreen extends StatefulWidget {
  const CompanyDetailsScreen(this.companyId, {super.key});
  final String? companyId;

  @override
  State<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late final ValueNotifier<String> _currentIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    _currentIndex = ValueNotifier<String>(0.toString());
    _currentIndex.addListener(() {
      _tabController.animateTo(int.parse(_currentIndex.value));
    });
  }

  final Map<String, String> _tabsMap = {
    '0': AppStrings.aboutTheCompany.tr(),
    '1': AppStrings.insurances.tr(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.basic(
          title: AppStrings.companyDetails.tr(),
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
                    itemPadding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.s72,
                            vertical: AppValues.mediumSmall)
                        .r,
                    segments: _tabsMap,
                    backgroundColor: AppColors.white,
                    activeStyle: extraSmallHeadlineStyle(),
                    inactiveStyle: smallDarkGrayBodyStyle(),
                    sliderColor: AppColors.grayLight,
                    sliderDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppValues.mediumRadius.r,
                      ),
                      color: AppColors.lightest,
                      border: Border.all(color: AppColors.lightGray),
                    ),
                    shadow: const [],
                  ),
                ),
                const CustomDivider()
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [AboutCompanyTab(widget.companyId), const InsurancesTab()],
        ));
  }
}
