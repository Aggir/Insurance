import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/data_classes/my_insurances_page_parameters.dart';
import 'package:insurance_app/presentation/blocs/issue_insurance/issue_insurance_cubit.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/font_manager.dart';
import 'package:insurance_app/presentation/theme/styles_manager.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/secondary_button.dart';
import 'package:insurance_app/presentation/widgets/snackbars.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/router/routes.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/primary_button.dart';

class InstallmentDetailsStepPage extends StatefulWidget {
  const InstallmentDetailsStepPage({super.key});

  @override
  State<InstallmentDetailsStepPage> createState() =>
      _InstallmentDetailsStepPageState();
}

class _InstallmentDetailsStepPageState
    extends State<InstallmentDetailsStepPage> {
  bool isPayLater = false;

  void _completeTheInsurancePayment(context) {
    final cubit = BlocProvider.of<IssueInsuranceCubit>(context);
    DialogService.loadLoadingDialog(context);
    cubit.issueInsurance();
    isPayLater = false;
  }

  void _issueTheInsurancePolicyAndPayLate(BuildContext context) {
    final cubit = BlocProvider.of<IssueInsuranceCubit>(context);
    DialogService.loadLoadingDialog(context);
    cubit.issueInsurance();
    isPayLater = true;
  }

  bool get _radiosSelected =>
      selectedRadio.contains('1') &&
      selectedRadio.contains('2') &&
      selectedRadio.contains('3');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: constraints.copyWith(
            minHeight: constraints.maxHeight,
            maxHeight: double.infinity,
          ),
          child: BlocListener<IssueInsuranceCubit, IssueInsuranceState>(
            listener: (context, state) {
              if (state.issueInsuranceStatus.isFailure) {
                DialogService.dispose();
                SnackBars.error(context, state.issueInsuranceErrorMessage!);
              } else if (state.issueInsuranceStatus.isSuccess) {
                DialogService.dispose();
                if (isPayLater) {
                  context.go(AppScreen.myVehicles.toPath, extra: true);
                } else {
                  context.go(
                    AppScreen.myInsurances.toPath,
                    extra: MyInsurancesPageParameters(
                      pageIndex: 2,
                      isPaymentModalShown: true,
                      selectedInsurance: state.insurance,
                    ),
                  );
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: AppValues.large.h,
                left: AppValues.mediumLarge.w,
                right: AppValues.mediumLarge.w,
                bottom: (AppValues.large).h,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        AppStrings.installmentDetails.tr(),
                        style: largeHeadlineStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CustomSpacers.mediumLarge(),
                    _installmentDetailsWidget(context),
                    CustomSpacers.medium(),
                    Text(
                      AppStrings.pleaseAcceptToContinue.tr(),
                      style: extraSmallHeadlineStyle(),
                    ),
                    RadioListTile(
                      title: Text(
                        AppStrings.iAcceptTheGeneralTermsOfTheInsurancePolicy
                            .tr(),
                        style: bodyStyle(),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      value: '1',
                      toggleable: true,
                      groupValue: selectedRadio.contains('1') ? '1' : null,
                      onChanged: (v) => setState(() {
                        if (selectedRadio.contains('1')) {
                          selectedRadio.remove('1');
                        } else {
                          selectedRadio.add('1');
                        }
                      }),
                    ),
                    RadioListTile(
                      title: Text(
                        AppStrings.iAgreeToPayTheFeeAsShownInTheTotal.tr(),
                        style: bodyStyle(),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      toggleable: true,
                      value: '2',
                      groupValue: selectedRadio.contains('2') ? '2' : null,
                      onChanged: (v) => setState(() {
                        if (selectedRadio.contains('2')) {
                          selectedRadio.remove('2');
                        } else {
                          selectedRadio.add('2');
                        }
                      }),
                    ),
                    RadioListTile(
                      title: Text(
                        AppStrings.iAgreeThatTheEnteredInfoAreCorrect.tr(),
                        style: bodyStyle(),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      toggleable: true,
                      value: '3',
                      groupValue: selectedRadio.contains('3') ? '3' : null,
                      onChanged: (v) => setState(() {
                        if (selectedRadio.contains('3')) {
                          selectedRadio.remove('3');
                        } else {
                          selectedRadio.add('3');
                        }
                      }),
                    ),
                    const Spacer(),
                    PrimaryButton.fullWidth(
                      onPressed: _radiosSelected
                          ? () => _completeTheInsurancePayment(context)
                          : null,
                      child: Text(
                          AppStrings.completeTheInsurancePolicyPayment.tr()),
                    ),
                    CustomSpacers.medium(),
                    SecondaryButton.fullWidth(
                      onPressed: _radiosSelected
                          ? () => _issueTheInsurancePolicyAndPayLate(context)
                          : null,
                      child: Text(
                          AppStrings.issueTheInsurancePolicyAndPayLater.tr()),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _installmentDetailsWidget(BuildContext context) {
    return BlocBuilder<IssueInsuranceCubit, IssueInsuranceState>(
      builder: (context, state) {
        return Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                SvgAssets.installmentCard, fit: BoxFit.fill,
                // width: double.infinity,f
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                      horizontal: AppValues.medium,
                      vertical: AppValues.mediumLarge)
                  .r,
              child: Column(
                children: [
                  _detailRow(
                      AppStrings.netInstallment.tr(),
                      double.parse(state.insurancePrice ?? '')
                          .toStringAsFixed(3)),
                  CustomSpacers.medium(),
                  _detailRow(AppStrings.tax.tr(), '1.000'),
                  CustomSpacers.medium(),
                  _detailRow(AppStrings.stampDuty.tr(), '0.500'),
                  CustomSpacers.medium(),
                  _detailRow(AppStrings.supervision.tr(), '0.320'),
                  CustomSpacers.medium(),
                  _detailRow(AppStrings.issuanceFee.tr(), '1.000'),
                  CustomSpacers.mediumLarge(),
                  Container(
                    color: AppColors.primaryLight,
                    width: double.infinity,
                    height: 1.r,
                  ),
                  CustomSpacers.mediumLarge(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.total.tr(),
                        style: mediumSmallHeadlineStyle(),
                      ),
                      Text(
                        '${(double.parse(state.insurancePrice!) + 2.820).toStringAsFixed(3)} ${AppStrings.currency.tr()}',
                        style: getExtraBoldStyle(
                            fontSize: FontSize.s16, color: AppColors.black),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: darkGrayBodyStyle(),
        ),
        Text(
          value.toString(),
          style: smallHeadlineStyle(),
        ),
      ],
    );
  }

  Set<String> selectedRadio = {};
}
