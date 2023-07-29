import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/widgets/custom_drop_down_field.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import '../../../../app/app_strings.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';

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

  bool _isSortByTheLowest = true;

  void _searchButtonFunction(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (widget.isComparePricesShown) {
        context.pop();
      } else {
        context.go(Routes.comparePricesRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
            _customRadioRow(value: false, title: AppStrings.highestPrice.tr()),
          ],
        ),
        CustomSpacers.large(),
        PrimaryButton.fullWidth(
            onPressed: () => _searchButtonFunction(context),
            child: Text(AppStrings.search.tr()))
      ],
    );
  }

  Widget _form(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomDropDownField(
            hintText: AppStrings.selectInsuranceType.tr(),
            items: DUMMY.test
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
            hintText: AppStrings.selectInsurancePolicy.tr(),
            items: DUMMY.typesOfCarInsurance
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
            hintText: AppStrings.selectTheHorsepowerOfTheEngine.tr(),
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
        ],
      ),
    );
  }

  Widget _customRadioRow({required bool value, required String title}) {
    return InkWell(
      onTap: () => setState(() {
        _isSortByTheLowest = value;
      }),
      child: Row(
        children: [
          Radio(
              visualDensity: VisualDensity.compact,
              value: value,
              groupValue: _isSortByTheLowest,
              onChanged: (_) {
                setState(() {
                  _isSortByTheLowest = value;
                });
              }),
          Text(
            title,
            style: darkGrayBodyStyle(),
          )
        ],
      ),
    );
  }
}
