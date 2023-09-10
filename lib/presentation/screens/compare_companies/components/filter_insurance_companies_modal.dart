import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/blocs/compare_companies/compare_companies_cubit.dart';
import 'package:insurance_app/presentation/widgets/custom_drop_down_field.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';
import '../../../../app/app_strings.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/dialog_service.dart';

class FilterInsuranceCompaniesModal extends StatefulWidget {
  const FilterInsuranceCompaniesModal(
      {this.isComparePricesShown = false, super.key});
  final bool isComparePricesShown;
  @override
  State<FilterInsuranceCompaniesModal> createState() =>
      _FilterInsuranceCompaniesModalState();
}

class _FilterInsuranceCompaniesModalState
    extends State<FilterInsuranceCompaniesModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _searchButtonFunction(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      DialogService.loadLoadingDialog(context);
      BlocProvider.of<CompareCompaniesCubit>(context).fetchCompaniesPrices();
    }
  }

  @override
  void initState() {
    final cubit = BlocProvider.of<CompareCompaniesCubit>(context);
    if (!widget.isComparePricesShown) {
      cubit.clear();
    }
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await DialogService.loadLoadingDialog(context);
      },
    );
    cubit.fetchInsuranceTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompareCompaniesCubit, CompareCompaniesState>(
      listenWhen: (previous, current) =>
          previous.fetchCompaniesPricesStatus !=
          current.fetchCompaniesPricesStatus,
      listener: (context, state) {
        if (state.fetchCompaniesPricesStatus.isFailure) {
          DialogService.dispose();
          SnackBars.error(context, state.fetchCompaniesPricesErrorMessage!);
        } else if (state.fetchCompaniesPricesStatus.isSuccess) {
          DialogService.dispose();
          if (widget.isComparePricesShown) {
            context.pop();
          } else {
            context.pop();
            context.push(AppScreen.comparePrices.toPath);
          }
        }
      },
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(
          top: AppValues.extraLarge,
          left: AppValues.mediumLarge,
          right: AppValues.mediumLarge,
          bottom: AppValues.mediumLarge,
        ).r,
        children: [
          Text(
            AppStrings.insuranceCompaniesFilter.tr(),
            style: largeHeadlineStyle(),
            textAlign: TextAlign.center,
          ),
          CustomSpacers.medium(),
          Text(
            AppStrings.youCanFindOutThePricesByFiltering.tr(),
            style: smallDarkGrayBodyStyle(),
            textAlign: TextAlign.center,
          ),
          CustomSpacers.extraLarge(),
          _form(context),
          CustomSpacers.medium(),
          Text(
            AppStrings.sortBy.tr(),
            style: smallDarkGrayBodyStyle(),
          ),
          CustomSpacers.medium(),
          Row(
            children: [
              _customRadioRow(value: true, title: AppStrings.lowestPrice.tr()),
              CustomSpacers.medium(),
              _customRadioRow(
                  value: false, title: AppStrings.highestPrice.tr()),
            ],
          ),
          CustomSpacers.large(),
          PrimaryButton.fullWidth(
              onPressed: () => _searchButtonFunction(context),
              child: Text(AppStrings.search.tr()))
        ],
      ),
    );
  }

  Widget _form(BuildContext context) {
    final cubit = BlocProvider.of<CompareCompaniesCubit>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocConsumer<CompareCompaniesCubit, CompareCompaniesState>(
            listenWhen: (previous, current) =>
                previous.fetchInsuranceTypesStatus !=
                current.fetchInsuranceTypesStatus,
            listener: (context, state) {
              if (state.fetchInsuranceTypesStatus.isFailure) {
                DialogService.dispose();
                SnackBars.error(
                    context, state.fetchInsuranceTypesErrorMessage!);
              } else if (state.fetchInsuranceTypesStatus.isSuccess) {
                DialogService.dispose();
              }
            },
            builder: (context, state) {
              return CustomDropDownField(
                onChanged: (value) =>
                    cubit.selectInsuranceType(int.parse(value)),
                hintText: AppStrings.selectInsuranceType.tr(),
                items: state.insuranceTypes == null
                    ? []
                    : state.insuranceTypes!
                        .map(
                          (insuranceType) => DropdownMenuItem(
                            value: insuranceType.id.toString(),
                            child: Text(
                              insuranceType.name,
                              style: bodyStyle(),
                            ),
                          ),
                        )
                        .toList(),
              );
            },
          ),
          CustomSpacers.medium(),
          // CustomDropDownField(
          //   onChanged: (value) => cubit.selectHorsePower(int.parse(value)),
          //   hintText: AppStrings.horsepower.tr(),
          //   items: DUMMY.horsePower
          //       .map(
          //         (value) => DropdownMenuItem(
          //           value: value.toString(),
          //           child: Text(
          //             value.toString(),
          //             style: bodyStyle(),
          //           ),
          //         ),
          //       )
          //       .toList(),
          // ),
          // CustomSpacers.medium(),
          // CustomDropDownField(
          //   onChanged: (value) => cubit.selectMaxPassengers(int.parse(value)),
          //   hintText: AppStrings.seatsWithoutTheDriver.tr(),
          //   items: DUMMY.seatsNumberWithoutTheDriver
          //       .map(
          //         (value) => DropdownMenuItem(
          //           value: value.toString(),
          //           child: Text(
          //             value.toString(),
          //             style: bodyStyle(),
          //           ),
          //         ),
          //       )
          //       .toList(),
          // ),
        ],
      ),
    );
  }

  Widget _customRadioRow({required bool value, required String title}) {
    return InkWell(
      onTap: () => BlocProvider.of<CompareCompaniesCubit>(context)
          .setIsSortByMinimum(value),
      child: BlocBuilder<CompareCompaniesCubit, CompareCompaniesState>(
        builder: (context, state) {
          return Row(
            children: [
              Radio(
                  visualDensity: VisualDensity.compact,
                  value: value,
                  groupValue: state.isSortByMinimum,
                  onChanged: (value) =>
                      BlocProvider.of<CompareCompaniesCubit>(context)
                          .setIsSortByMinimum(value as bool)),
              Text(
                title,
                style: darkGrayBodyStyle(),
              )
            ],
          );
        },
      ),
    );
  }
}
