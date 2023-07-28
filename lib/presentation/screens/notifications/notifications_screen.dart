import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/enums/notification_types_enum.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';

import '../../../app/assets_manager.dart';
import '../../theme/app_theme.dart';
import '../../theme/text_style_manager.dart';
import '../../widgets/custom_spacers.dart';
import '../../widgets/primary_button.dart';
import '../insurance_payment/components/payment_method_modal.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  _backToHomeScreenFunction(BuildContext context) {
    context.go(Routes.homeRoute);
  }

  _renewalFunction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(AppValues.largeRadius),
        ),
      ),
      builder: (context) => const PaymentMethodModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return Scaffold(
      appBar: CustomAppBar.basic(
        title: AppStrings.notifications.tr(),
        backButton: () {
          context.go(Routes.homeRoute);
        },
      ),
      body: random.nextBool()
          ? _emptyNotifications(context)
          : _dummyNotificationsList(context),
    );
  }

  Widget _dummyNotificationsList(BuildContext context) {
    String time = 'السبت 9:30 م';
    return ListView(
      children: [
        CustomSpacers.medium(),
        _notificationWidget(
          context,
          NotificationTypes.accepted,
          AppStrings.theInsuranceHasBeenApproved.tr(),
          time,
        ),
        const CustomDivider(),
        _notificationWidget(
          context,
          NotificationTypes.reminderAboutExpirationDate,
          AppStrings.theDocumentIsAboutToExpire.tr(),
          time,
        ),
        const CustomDivider(),
        _notificationWidget(
          context,
          NotificationTypes.expiryReminder,
          AppStrings.theDocumentHasExpired.tr(),
          time,
        ),
        const CustomDivider(),
        _notificationWidget(
          context,
          NotificationTypes.paymentCompleted,
          AppStrings.theInsuranceHasBeenPaid.tr(),
          time,
        ),
      ],
    );
  }

  Widget _notificationWidget(BuildContext context, NotificationTypes type,
      String content, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppValues.medium, horizontal: AppValues.mediumLarge),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: AppSizes.s16.r,
                backgroundColor: type.svgBackgroundColor,
                child: SvgPicture.asset(
                  type.svgPath,
                  width: AppSizes.s22.r,
                  height: AppSizes.s22.r,
                  colorFilter: ColorFilter.mode(type.svgColor, BlendMode.srcIn),
                ),
              ),
              CustomSpacers.medium(),
              SizedBox(
                width: AppSizes.s280.r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(content),
                    CustomSpacers.small(),
                    Text(time, style: extraSmallGrayBodyStyle()),
                  ],
                ),
              ),
            ],
          ),
          if (type.isActionNotification)
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: AppSizes.s90.r,
                child: PrimaryButton(
                  child: Text(
                    AppStrings.renewal.tr(),
                  ),
                  onPressed: () => _renewalFunction(context),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _emptyNotifications(BuildContext context) {
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
