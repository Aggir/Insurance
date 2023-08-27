import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/notification.dart';
import 'package:insurance_app/presentation/blocs/notifications/notifications_cubit.dart';
import 'package:insurance_app/presentation/screens/notifications/components/empty_notifications_list.dart';
import 'package:insurance_app/presentation/screens/notifications/components/notification_list_tile.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_divider.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';
import '../../../app/router/routes.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    BlocProvider.of<NotificationsCubit>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go(AppScreen.home.toPath);
        return false;
      },
      child: BlocListener<NotificationsCubit, NotificationsState>(
        listenWhen: (previous, current) =>
            previous.fetchNotificationsStatus !=
            current.fetchNotificationsStatus,
        listener: (context, state) {
          if (state.fetchNotificationsStatus.isFailure) {
            SnackBars.error(context, state.fetchNotificationsErrorMessage!);
          } else if (state.fetchNotificationsStatus.isSuccess &&
              state.countUnseen > 0) {
            BlocProvider.of<NotificationsCubit>(context).toggleSeen();
          }
        },
        child: Scaffold(
            appBar: CustomAppBar.basic(
              title: AppStrings.notifications.tr(),
              backButton: () {
                context.go(AppScreen.home.toPath);
              },
            ),
            body: BlocConsumer<NotificationsCubit, NotificationsState>(
              listenWhen: (previous, current) =>
                  previous.toggleSeenStatus != current.toggleSeenStatus,
              listener: (context, state) {
                if (state.toggleSeenStatus.isFailure) {
                  SnackBars.error(context, state.toggleSeenErrorMessage!);
                }
              },
              builder: (context, state) {
                if (state.fetchNotificationsStatus.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                } else if (state.fetchNotificationsStatus.isSuccess &&
                    ((state.seenNotifications?.isNotEmpty ?? false) ||
                        (state.unseenNotifications?.isNotEmpty ?? false))) {
                  return ListView(children: [
                    if (state.unseenNotifications?.isNotEmpty ?? false)
                      notificationsList(state.unseenNotifications ?? [],
                          AppStrings.unreadNotifications.tr()),
                    if (state.seenNotifications?.isNotEmpty ?? false)
                      notificationsList(state.seenNotifications ?? [],
                          AppStrings.readNotifications.tr()),
                  ]);
                } else {
                  return const EmptyNotificationsList();
                }
              },
            )),
      ),
    );
  }

  Widget notificationsList(
      List<NotificationEntity> notificationsList, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppValues.medium),
          child: Text(
            '$title:',
            style: smallDarkGrayHeadlineStyle(),
          ),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const CustomDivider(),
          shrinkWrap: true,
          itemCount: notificationsList.length,
          itemBuilder: (context, index) => NotificationListTile(
            notificationsList[index],
          ),
        ),
      ],
    );
  }
}
