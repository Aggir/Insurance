import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/enums/notification_type.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/notification.dart';
import 'package:insurance_app/presentation/blocs/notifications/notifications_cubit.dart';
import 'package:insurance_app/presentation/screens/payment/components/payment_type_modal.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile(this.notification, {super.key});
  final NotificationEntity notification;

  _renewalFunction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: AppValues.modalShape,
      builder: (context) => const PaymentTypeModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsCubit, NotificationsState>(
      listenWhen: (previous, current) =>
          previous.toggleReadStatus != current.toggleReadStatus,
      listener: (context, state) {
        if (state.toggleReadStatus.isFailure) {
          SnackBars.error(context, state.toggleReadErrorMessage!);
        }
      },
      child: InkWell(
        onTap: notification.isRead
            ? null
            : () => BlocProvider.of<NotificationsCubit>(context)
                .toggleRead(notification.id),
        child: Container(
          color: notification.isRead
              ? null
              : AppColors.primaryLightest.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppValues.medium, horizontal: AppValues.mediumLarge),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: AppSizes.s16.r,
                      backgroundColor: notification.type.getBackgroundColor(),
                      child: SvgPicture.network(
                        notification.icon,
                        width: AppSizes.s22.r,
                        height: AppSizes.s22.r,
                        colorFilter: ColorFilter.mode(
                            notification.type.getIconColor(), BlendMode.srcIn),
                      ),
                    ),
                    CustomSpacers.medium(),
                    SizedBox(
                      width: AppSizes.s280.r,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notification.title),
                          CustomSpacers.small(),
                          Text(
                              '${DateFormat('yyyy-MM-dd    /    h:mm:ss').format(notification.createdAt)} ${Intl.withLocale('ar', () => DateFormat('a').format(notification.createdAt))}',
                              style: extraSmallGrayBodyStyle()),
                        ],
                      ),
                    ),
                  ],
                ),
                if (notification.url.isNotEmpty)
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
          ),
        ),
      ),
    );
  }
}
