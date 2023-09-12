import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/theme/font_manager.dart';
import 'package:insurance_app/presentation/widgets/pressable_text.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';
import 'dart:ui' as ui;
import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../blocs/user/user_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';

class ProfileDetailsState extends StatelessWidget {
  const ProfileDetailsState({super.key});

  void _sendEmailVerification(BuildContext context) {
    BlocProvider.of<UserCubit>(context).confirmEmail();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Column(
          children: [
            _infoCardWidget(
              context,
              SvgAssets.envelope,
              AppStrings.emailAddress.tr(),
              state.user?.email ?? Constants.empty,
              isEmailValid: state.user?.emailVerifiedAt.isNotEmpty ?? false,
            ),
            CustomSpacers.medium(),
            _infoCardWidget(
              context,
              SvgAssets.phone,
              AppStrings.phoneNumber.tr(),
              '${state.user?.phoneCode}${state.user?.phone}',
              isLTR: true,
            ),
            CustomSpacers.medium(),
            _infoCardWidget(
              context,
              SvgAssets.calendar,
              AppStrings.birthDate.tr(),
              state.user?.dateOfBirth ?? Constants.empty,
            ),
            CustomSpacers.medium(),
            _infoCardWidget(
              context,
              SvgAssets.idCard,
              AppStrings.nationality.tr(),
              ((state.user?.isLibyan ?? false)
                      ? AppStrings.libyan
                      : AppStrings.nonLibyan)
                  .tr(),
            ),
          ],
        );
      },
    );
  }

  Widget _infoCardWidget(
      BuildContext context, String svgPath, String title, String text,
      {bool? isLTR, bool? isEmailValid}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isEmailValid != null && !isEmailValid) ...[
          Text.rich(
            TextSpan(
              text: '${AppStrings.yourEmailAddressHasNotBeenVerified.tr()} ',
              children: [
                TextSpan(
                    text: AppStrings
                        .weHaveSentYouAnEmailWithLinkToVerifyYourEmail
                        .tr()),
              ],
              style: smallGrayBodyStyle().copyWith(color: AppColors.primary),
            ),
          ),
          CustomSpacers.small(),
        ],
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppValues.mediumSmall).r,
          decoration: BoxDecoration(
            color: AppColors.lightest,
            border: Border.all(color: AppColors.grayLight),
            borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.grayLight),
                ),
                child: SvgPicture.asset(
                  svgPath,
                  height: AppSizes.s28.r,
                  width: AppSizes.s28.r,
                  colorFilter:
                      ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                ),
              ),
              CustomSpacers.medium(),
              SizedBox(
                width: AppSizes.s260.r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: extraSmallGrayBodyStyle(),
                    ),
                    Directionality(
                      textDirection: isLTR != null
                          ? isLTR
                              ? ui.TextDirection.ltr
                              : ui.TextDirection.rtl
                          : Directionality.of(context),
                      child: Text(
                        text,
                        style: smallBodyStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (isEmailValid != null)
                Container(
                  height: AppSizes.s16.r,
                  width: AppSizes.s16.r,
                  decoration: BoxDecoration(
                    color: (!isEmailValid)
                        ? AppColors.primary
                        : AppColors.secondary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    (!isEmailValid) ? Icons.priority_high_rounded : Icons.check,
                    size: AppSizes.s12.r,
                    color: AppColors.white,
                  ),
                ),
            ],
          ),
        ),
        if (isEmailValid != null && !isEmailValid) ...[
          CustomSpacers.small(),
          Row(
            children: [
              Text(
                '${AppStrings.didNotReceiveTheConfirmationLink.tr()} ',
                style: grayBodyStyle(),
              ),
              BlocConsumer<UserCubit, UserState>(
                listenWhen: (previous, current) =>
                    previous.confirmEmailStatus != current.confirmEmailStatus,
                listener: (context, state) {
                  if (state.confirmEmailStatus.isFailure) {
                    SnackBars.error(context, state.confirmEmailErrorMessage!);
                  } else if (state.confirmEmailStatus.isSuccess) {
                    SnackBars.success(context,
                        AppStrings.sendEmailConfirmationLinkSuccess.tr());
                  }
                },
                builder: (context, state) {
                  if (state.confirmEmailStatus.isLoading) {
                    return SizedBox(
                        width: AppSizes.s16.r,
                        height: AppSizes.s16.r,
                        child: CircularProgressIndicator(
                          strokeWidth: AppSizes.s2.r,
                        ));
                  }
                  return PressableText(
                    text: AppStrings.sendAgain.tr(),
                    onTap: () => _sendEmailVerification(context),
                    fontSize: FontSize.s14,
                  );
                },
              )
            ],
          ),
          CustomSpacers.small(),
        ]
      ],
    );
  }
}
