import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/presentation/app_router.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../blocs/signup/signup_cubit.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/page_content_padding.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/identity_verification_image.dart';
import '../components/signup_footer_row.dart';

class SignUpSelectVerificationMethodStep extends StatelessWidget {
  const SignUpSelectVerificationMethodStep({super.key});
  _nextButtonFunction(BuildContext context) {
    context.go(Routes.signupVerificationStepRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SingleChildScrollView(
          child: SizedBox(
        height: MediaQuery.of(context).size.height -
            kToolbarHeight -
            AppSizes.s30.r,
        child: PageContentPadding(
          child: Column(
            children: [
              const FramedImage(
                imagePath: ImageAssets.identityVerificationPassport,
              ),
              CustomSpacers.large(),
              _headlineTextWidget(),
              CustomSpacers.medium(),
              _bodyTextWidget(),
              CustomSpacers.large(),
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
              const Spacer(),
              _nextButton(context),
              CustomSpacers.medium(),
              const SignUpFooterRow(),
            ],
          ),
        ),
      )),
    );
  }

  Widget _headlineTextWidget() {
    return Text(
      AppStrings.signupScreenHeader,
      style: largeHeadlineStyle(),
    ).tr();
  }

  Widget _bodyTextWidget() {
    return Text(
      AppStrings.signupScreenDescription,
      style: darkGrayBodyStyle(),
    ).tr();
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
            padding: const EdgeInsets.all(AppValues.small).r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
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
                CustomSpacers.small(),
                Text(
                  text,
                  style:
                      isSelected ? smallHeadlineStyle() : darkGrayBodyStyle(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _nextButton(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return PrimaryButton.fullWidth(
          onPressed: state.verificationType.isNotEmpty
              ? () => _nextButtonFunction(context)
              : null,
          child: Text(AppStrings.next.tr().toUpperCase()),
        );
      },
    );
  }
}
