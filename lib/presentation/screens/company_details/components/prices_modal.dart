import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/widgets/cupertino_switch_tile.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';

import '../../../../app/app_strings.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_drop_down_field.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/primary_button.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;

class PricesModal extends StatefulWidget {
  const PricesModal({super.key});

  @override
  State<PricesModal> createState() => _PricesModalState();
}

class _PricesModalState extends State<PricesModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPublicUse = false;
  bool _isTotalShown = false;

  _knowThePriceFunction(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isTotalShown = true;
      });
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
        CustomSpacers.medium(),
        CupertinoSwitchTile(
            onTap: () {
              setState(() {
                _isPublicUse = !_isPublicUse;
              });
            },
            text: AppStrings.publicUse.tr(),
            value: _isPublicUse),
        CustomSpacers.large(),
        if (!_isTotalShown)
          PrimaryButton.fullWidth(
              onPressed: () => _knowThePriceFunction(context),
              child: Text(AppStrings.knowThePrice.tr())),
        if (_isTotalShown) ...[
          const CustomDivider(),
          CustomSpacers.large(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '28.125 ${AppStrings.currency.tr()}',
                style: mediumExBoldStyle(),
              ),
              PrimaryButton(
                onPressed: () => context.go(AppScreen.issueInsurance.toPath),
                child: Text(AppStrings.issueAnInsurance.tr()),
              ),
            ],
          )
        ]
      ],
    );
  }

  Widget _form(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomDropDownField(
            hintText: AppStrings.selectVehicleType.tr(),
            items: DUMMY.carBrands
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
          CustomSpacers.medium(),
          CustomDropDownField(
            hintText: AppStrings.selectSeatsNumber.tr(),
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
      ),
    );
  }
}
