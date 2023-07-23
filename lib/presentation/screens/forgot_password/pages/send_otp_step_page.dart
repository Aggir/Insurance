import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/blocs/forgot_password/forgot_password_cubit.dart';
import 'package:insurance_app/presentation/screens/forgot_password/components/forgot_password_footer_row.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/card_page_container.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/primary_button.dart';

class ForgotPasswordSendOtpPage extends StatefulWidget {
  const ForgotPasswordSendOtpPage({super.key});

  @override
  State<ForgotPasswordSendOtpPage> createState() =>
      _ForgotPasswordSendOtpPageState();
}

class _ForgotPasswordSendOtpPageState extends State<ForgotPasswordSendOtpPage> {
  bool formIsNotEmpty = false;

  void _checkIsFormEmpty() {
    final cubit = BlocProvider.of<ForgotPasswordCubit>(context);
    if (cubit.emailOrPhoneNumberController.text.trim().isNotEmpty) {
      setState(() {
        formIsNotEmpty = true;
      });
    } else {
      setState(() {
        formIsNotEmpty = false;
      });
    }
  }

  _nextButtonFunction(context) async {
    FocusScope.of(context).unfocus();
    BlocProvider.of<ForgotPasswordCubit>(context).confirmSendOtpForm();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryLightest,
                  image: const DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage(ImageAssets.forgotPasswordBackground),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CardPageContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _headlineTextWidget(),
                    CustomSpacers.medium(),
                    _bodyTextWidget(),
                    CustomSpacers.large(),
                    CustomSpacers.small(),
                    _loginForm(context),
                    CustomSpacers.large(),
                    CustomSpacers.small(),
                    _nextButton(context),
                    CustomSpacers.medium(),
                    const ForgotPasswordFooterRow(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headlineTextWidget() {
    return Text(
      AppStrings.forgotPassword,
      style: largeHeadlineStyle(),
    ).tr();
  }

  Widget _bodyTextWidget() {
    return Text(
      AppStrings.forgotPasswordScreenDescription,
      style: darkGrayBodyStyle(),
    ).tr();
  }

  Widget _loginForm(BuildContext context) {
    final cubit = BlocProvider.of<ForgotPasswordCubit>(context);
    return Form(
      key: cubit.sendOtpForm,
      onChanged: _checkIsFormEmpty,
      child: CustomTextFormField(
        hintText: AppStrings.phoneNumberOrEmailAddress.tr(),
        controller: cubit.emailOrPhoneNumberController,
        label: AppStrings.phoneNumberOrEmailAddress.tr(),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state.sendOtpStatus.isFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.sendOtpError!)));
        } else if (state.sendOtpStatus.isSuccess) {
          GoRouter.of(context).go(Routes.forgotPasswordVerifyOtpStepRoute);
        }
      },
      builder: (context, state) {
        return PrimaryButton.fullWidth(
          onPressed: state.sendOtpStatus.isLoading
              ? () {}
              : formIsNotEmpty
                  ? () => _nextButtonFunction(context)
                  : null,
          child: state.sendOtpStatus.isLoading
              ? SizedBox(
                  height: AppSizes.s20,
                  width: AppSizes.s20,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: AppSizes.s2,
                  ),
                )
              : Text(AppStrings.next.tr().toUpperCase()),
        );
      },
    );
  }
}
