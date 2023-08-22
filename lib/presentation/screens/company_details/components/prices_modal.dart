import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/blocs/companies/companies_cubit.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';

import '../../../../app/app_strings.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_drop_down_field.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/dialog_service.dart';
import '../../../widgets/primary_button.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;

class PricesModal extends StatefulWidget {
  const PricesModal({super.key});

  @override
  State<PricesModal> createState() => _PricesModalState();
}

class _PricesModalState extends State<PricesModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _knowThePriceFunction(BuildContext context) {
    final cubit = BlocProvider.of<CompaniesCubit>(context);
    if (_formKey.currentState!.validate()) {
      cubit.calculatePrice();
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompaniesCubit>(context).fetchPricesFormData();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        DialogService.loadLoadingDialog(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompaniesCubit, CompaniesState>(
      listenWhen: (previous, current) =>
          previous.fetchPricesFormDataStatus !=
          current.fetchPricesFormDataStatus,
      listener: (context, state) {
        if (state.fetchPricesFormDataStatus.isFailure) {
          DialogService.dispose();
          SnackBars.error(context, state.fetchPricesFormDataErrorMessage!);
        } else if (state.fetchPricesFormDataStatus.isSuccess) {
          DialogService.dispose();
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
            AppStrings.prices.tr(),
            style: largeHeadlineStyle(),
            textAlign: TextAlign.center,
          ),
          CustomSpacers.medium(),
          Text(
            AppStrings.pricesModalDescription.tr(),
            style: smallDarkGrayBodyStyle(),
            textAlign: TextAlign.center,
          ),
          CustomSpacers.extraLarge(),
          _form(context),
          CustomSpacers.large(),
          BlocConsumer<CompaniesCubit, CompaniesState>(
            listenWhen: (previous, current) =>
                previous.calculatePriceStatus != current.calculatePriceStatus,
            listener: (context, state) {
              if (state.calculatePriceStatus.isFailure) {
                SnackBars.error(context, state.calculatePriceErrorMessage!);
              }
            },
            builder: (context, state) {
              if (!state.calculatePriceStatus.isSuccess) {
                return PrimaryButton.fullWidth(
                    isLoading: state.calculatePriceStatus.isLoading,
                    onPressed: () => _knowThePriceFunction(context),
                    child: Text(AppStrings.knowThePrice.tr()));
              } else {
                return Column(children: [
                  const CustomDivider(),
                  CustomSpacers.large(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${state.price} ${AppStrings.currency.tr()}',
                        style: mediumExBoldStyle(),
                      ),
                      PrimaryButton(
                        onPressed: () =>
                            context.go(AppScreen.issueInsurance.toPath),
                        child: Text(AppStrings.issueAnInsurance.tr()),
                      ),
                    ],
                  )
                ]);
              }
            },
          )
        ],
      ),
    );
  }

  Widget _form(BuildContext context) {
    final cubit = BlocProvider.of<CompaniesCubit>(context);
    return Form(
      key: _formKey,
      child: BlocBuilder<CompaniesCubit, CompaniesState>(
        builder: (context, state) {
          return Column(
            children: [
              CustomDropDownField(
                hintText: AppStrings.selectInsuranceType.tr(),
                onChanged: (value) =>
                    cubit.selectInsuranceType(int.parse(value)),
                items: (state.companyPricesFormData?.insuranceTypes ?? [])
                    .map(
                      (type) => DropdownMenuItem(
                        value: type.id.toString(),
                        child: Text(
                          type.name,
                          style: bodyStyle(),
                        ),
                      ),
                    )
                    .toList(),
              ),
              CustomSpacers.medium(),
              CustomDropDownField(
                hintText: AppStrings.selectVehicleType.tr(),
                onChanged: (value) =>
                    cubit.selectVehicleBrand(int.parse(value)),
                items: (state.companyPricesFormData?.vehicleBrands ?? [])
                    .map(
                      (type) => DropdownMenuItem(
                        value: type.id.toString(),
                        child: Text(
                          type.name,
                          style: bodyStyle(),
                        ),
                      ),
                    )
                    .toList(),
              ),
              CustomSpacers.medium(),
              CustomDropDownField(
                hintText: AppStrings.selectTheHorsepowerOfTheEngine.tr(),
                onChanged: (value) => cubit.selectHorsePower(int.parse(value)),
                items: DUMMY.horsePower
                    .map(
                      (type) => DropdownMenuItem(
                        value: type['value'],
                        child: Text(
                          type['value'] ?? '',
                          style: bodyStyle(),
                        ),
                      ),
                    )
                    .toList(),
              ),
              CustomSpacers.medium(),
              CustomDropDownField(
                hintText: AppStrings.selectSeatsNumber.tr(),
                onChanged: (value) => cubit.selectSeatsCount(int.parse(value)),
                items: DUMMY.seatsNumber
                    .map(
                      (type) => DropdownMenuItem(
                        value: type['value'],
                        child: Text(
                          type['value'] ?? '',
                          style: bodyStyle(),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
