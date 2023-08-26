import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';

class EmptyNotificationsList extends StatelessWidget {
  const EmptyNotificationsList({super.key});

  _backToHomeScreenFunction(BuildContext context) {
    context.go(AppScreen.home.toPath);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppValues.large).r,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomSpacers.extraLarge(),
          CustomSpacers.large(),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: AppSizes.s160.r,
                height: AppSizes.s160.r,
                decoration: BoxDecoration(
                  color: AppColors.primaryLightest,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Image.asset(
                ImageAssets.notifications,
                height: AppSizes.s200.r,
              ),
            ],
          ),
          CustomSpacers.large(),
          Text(
            AppStrings.youHaveNoNotifications.tr(),
            style: mediumHeadlineStyle(),
          ),
          CustomSpacers.medium(),
          Text(
            AppStrings.youHaveNoNotificationsMessage.tr(),
            style: grayBodyStyle(),
            textAlign: TextAlign.center,
          ),
          CustomSpacers.large(),
          PrimaryButton.fullWidth(
            child: Text(AppStrings.backToHomeScreen.tr()),
            onPressed: () => _backToHomeScreenFunction(context),
          ),
        ]),
      ),
    );
  }
}
