import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/insurance.dart';
import 'package:insurance_app/presentation/blocs/my_insurances/my_insurances_cubit.dart';

import 'package:insurance_app/presentation/screens/home/components/insurance_list_item.dart';
import 'package:insurance_app/presentation/screens/payment/components/payment_method_modal.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart'
    show CustomSpacers;
import 'package:insurance_app/presentation/widgets/primary_button.dart';

import '../../../../app/router/routes.dart';

class MyInsurancesPage extends StatefulWidget {
  const MyInsurancesPage(
      {this.pageIndex,
      this.isPaymentModelShown = false,
      this.selectedInsuranceId,
      super.key});
  final int? pageIndex;
  final bool? isPaymentModelShown;
  final int? selectedInsuranceId;
  @override
  State<MyInsurancesPage> createState() => _MyInsurancesPageState();
}

class _MyInsurancesPageState extends State<MyInsurancesPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late final ValueNotifier<String> _currentIndex;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.pageIndex ?? 0,
      length: 4,
      vsync: this,
    );
    _currentIndex = ValueNotifier<String>(widget.pageIndex.toString());
    _currentIndex.addListener(() {
      _tabController.animateTo(int.parse(_currentIndex.value));
    });
    if (widget.isPaymentModelShown ?? false) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => showModalBottomSheet(
                context: context,
                shape: AppValues.modalShape,
                isScrollControlled: true,
                builder: (context) =>
                    PaymentMethodModal(widget.selectedInsuranceId ?? 1),
              ));
    }
  }

  final Map<String, String> _tabsMap = {
    '0': AppStrings.underProcessing.tr(),
    '1': AppStrings.issued.tr(),
    '2': AppStrings.notPaid.tr(),
    '3': AppStrings.expired.tr(),
  };
  _insuranceServicesButtonFunction(BuildContext context) {
    context.go(AppScreen.home.toPath);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go(AppScreen.home.toPath);
        return false;
      },
      child: SafeArea(
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
                  ))),
          body: BlocBuilder<MyInsurancesCubit, MyInsurancesState>(
            builder: (context, state) {
              return TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _underProcessing(state),
                    _issued(state),
                    _notPaid(state),
                    _expired(state),
                  ]);
            },
          ),
        ),
      ),
    );
  }

  Widget _underProcessing(MyInsurancesState state) {
    if (state.fetchInsurancesStatus.isLoading &&
        state.processingInsurances == null) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    } else if (state.processingInsurances?.isEmpty ?? true) {
      return _emptyState(AppStrings.underProcessing.tr());
    } else {
      return _customListViewBuilder(
          state.processingInsurances!,
          BlocProvider.of<MyInsurancesCubit>(context)
              .processingScrollController,
          state);
    }
  }

  Widget _issued(MyInsurancesState state) {
    if (state.fetchInsurancesStatus.isLoading &&
        state.activeInsurances == null) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    } else if (state.activeInsurances?.isEmpty ?? true) {
      return _emptyState(AppStrings.issued.tr());
    } else {
      return _customListViewBuilder(
          state.activeInsurances!,
          BlocProvider.of<MyInsurancesCubit>(context).activeScrollController,
          state);
    }
  }

  Widget _notPaid(MyInsurancesState state) {
    if (state.fetchInsurancesStatus.isLoading &&
        state.notPaidInsurances == null) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    } else if (state.notPaidInsurances?.isEmpty ?? true) {
      return _emptyState(AppStrings.notPaid.tr());
    } else {
      return _customListViewBuilder(
          state.notPaidInsurances!,
          BlocProvider.of<MyInsurancesCubit>(context).notPaidScrollController,
          state);
    }
  }

  Widget _expired(MyInsurancesState state) {
    if (state.fetchInsurancesStatus.isLoading &&
        state.expiredInsurances == null) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    } else if (state.expiredInsurances?.isEmpty ?? true) {
      return _emptyState(AppStrings.expired.tr());
    } else {
      return _customListViewBuilder(
          state.expiredInsurances!,
          BlocProvider.of<MyInsurancesCubit>(context).expiredScrollController,
          state);
    }
  }

  Widget _customListViewBuilder(List<InsuranceEntity> data,
      ScrollController controller, MyInsurancesState state) {
    return Stack(
      children: [
        ListView.separated(
          controller: controller,
          padding: const EdgeInsets.symmetric(
                  vertical: AppValues.large, horizontal: AppValues.medium)
              .r,
          separatorBuilder: (context, index) => CustomSpacers.medium(),
          itemCount: data.length,
          itemBuilder: (context, index) => InsuranceListItem(data[index]),
        ),
        if (state.fetchInsurancesStatus.isLoading)
          Align(
            alignment: Alignment.bottomCenter,
            child: CircleAvatar(
              backgroundColor: AppColors.lightest,
              radius: AppSizes.s20.r,
              child: Padding(
                padding: const EdgeInsets.all(AppValues.small).r,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: AppSizes.s4.r,
                ),
              ),
            ),
          ),
      ],
    );
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
              '${AppStrings.youDoNotHaveAnyInsurances.tr()} $text.',
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
