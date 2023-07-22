import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';

import '../../../../../app/assets_manager.dart';
import '../../../../app/app_strings.dart';
import '../../../blocs/signup/signup_cubit.dart';
import '../../../widgets/custom_spacers.dart';

class SelectVerificationType extends StatefulWidget {
  const SelectVerificationType({super.key});

  @override
  State<SelectVerificationType> createState() => _SelectVerificationTypeState();
}

class _SelectVerificationTypeState extends State<SelectVerificationType> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.selectIdentityVerificationType.tr(),
            style: smallDarkGrayBodyStyle(),
          ),
          CustomSpacers.medium(),
          _customRadioListTile(
            text: AppStrings.passport.tr(),
            svgPath: SvgAssets.passport,
            context,
          ),
          CustomSpacers.medium(),
          _customRadioListTile(
            text: AppStrings.idCard.tr(),
            svgPath: SvgAssets.idCard,
            context,
          ),
        ],
      ),
    );
  }

  _customRadioListTile(
    BuildContext context, {
    required String text,
    required String svgPath,
  }) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final bool isSelected = text == state.verificationType;
        return InkWell(
          onTap: () => cubit.setVerificationType(text),
          child: Container(
            padding: const EdgeInsets.all(AppValues.small),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppValues.inputRadius),
                boxShadow: [AppValues.boxShadow],
                color: isSelected ? AppColors.lightest : AppColors.white,
                border:
                    isSelected ? null : Border.all(color: AppColors.grayLight)),
            child: Row(
              children: [
                Radio(
                  value: text,
                  groupValue: state.verificationType,
                  onChanged: (value) =>
                      value != null ? cubit.setVerificationType(value) : null,
                  activeColor: AppColors.secondary,
                  // selected: true,
                  // selectedTileColor: AppColors.black,
                ),
                SvgPicture.asset(svgPath),
                const SizedBox(height: AppSizes.s10, width: AppSizes.s10),
                Text(
                  text,
                  style: isSelected
                      ? smallHeadlineStyle()
                          .copyWith(color: AppColors.blackText)
                      : darkGrayBodyStyle(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
