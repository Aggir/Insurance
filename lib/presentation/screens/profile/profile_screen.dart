import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_drop_down_field.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/custom_text_form_field.dart';

import '../../../app/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        title: AppStrings.myAccount.tr(),
        backButton: () {
          context.go(Routes.moreRoute);
        },
        actions: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              height: AppSizes.s48.r,
              width: AppSizes.s48.r,
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {},
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SvgPicture.asset(
                    SvgAssets.edit,
                    height: AppSizes.s32.r,
                    width: AppSizes.s32.r,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CustomDropDownField(
                hintText: "CITY",
                entries: Constants.cities
                    .map(
                      (option) => DropdownMenuEntry(
                        value: option['value'].toString(),
                        label: option['value'].toString(),
                        style: ButtonStyle(
                          textStyle:
                              MaterialStateProperty.all<TextStyle>(bodyStyle()),
                        ),
                      ),
                    )
                    .toList(),
              ),
              CustomSpacers.medium(),
              CustomTextFormField(
                hintText: "SSE",
              )
            ],
          ),
        ),
      ),
    );
  }
}
