import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../blocs/signup/signup_cubit.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/primary_button.dart';
import '../components/identity_verification_image.dart';
import '../components/signup_footer_row.dart';
import '../components/upload_verification_document.dart';

class SignUpNationalIdNumberPage extends StatefulWidget {
  const SignUpNationalIdNumberPage({super.key});

  @override
  State<SignUpNationalIdNumberPage> createState() =>
      _SignUpNationalIdNumberPageState();
}

class _SignUpNationalIdNumberPageState
    extends State<SignUpNationalIdNumberPage> {
  void _createAccountButtonFunction(BuildContext context) {
    FocusScope.of(context).unfocus();
    final cubit = BlocProvider.of<SignUpCubit>(context);
    if (cubit.confirmNationalIdNumberForm()) {
      cubit.signUp();
      context.go(Routes.homeRoute);
    }
  }

  bool formIsNotEmpty = false;

  void _checkIsFormEmpty() {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    if (cubit.nationalIdNumberController.text.trim().isNotEmpty) {
      setState(() {
        formIsNotEmpty = true;
      });
    } else {
      setState(() {
        formIsNotEmpty = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIsFormEmpty();
  }

  void _uploadFunction(BuildContext context) {
    BlocProvider.of<SignUpCubit>(context).uploadNationalIdPicture();
  }

  _removeFunction(BuildContext context) {
    BlocProvider.of<SignUpCubit>(context).removeNationalIdPicture();
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
              const IdentityVerificationImage(
                imagePath: ImageAssets.libya,
              ),
              CustomSpacers.large(),
              _headlineTextWidget(),
              CustomSpacers.medium(),
              _bodyTextWidget(),
              CustomSpacers.large(),
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return UploadDocument(
                    uploadFileStatus: state.nationalNumberStatus,
                    uploadFunction: () => _uploadFunction(context),
                    removeFunction: () => _removeFunction(context),
                    uploadStateText: AppStrings.uploadNationalIdPicture.tr(),
                    loadingAndSuccessStateText:
                        AppStrings.nationalIdPicture.tr(),
                    uploadedDocumentSvgPath: SvgAssets.nationalId,
                  );
                },
              ),
              CustomSpacers.medium(),
              _nationalIdNumberForm(),
              const Spacer(),
              _createAccountButton(context),
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
      AppStrings.identityVerificationHeader,
      style: largeHeadlineStyle(),
    ).tr();
  }

  Widget _bodyTextWidget() {
    return Text(
      AppStrings.identityVerificationDescription,
      style: darkGrayBodyStyle(),
      textAlign: TextAlign.center,
    ).tr();
  }

  Widget _nationalIdNumberForm() {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return Form(
      key: cubit.nationalIdNumberForm,
      onChanged: _checkIsFormEmpty,
      child: CustomTextFormField(
        controller: cubit.nationalIdNumberController,
        hintText: AppStrings.nationalIdNumber.tr(),
        maxLength: 12,
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _createAccountButton(context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return PrimaryButton.fullWidth(
          onPressed: (formIsNotEmpty && state.nationalNumberStatus.isSuccess)
              ? () => _createAccountButtonFunction(context)
              : null,
          child: Text(
            AppStrings.createAccount.tr(),
          ),
        );
      },
    );
  }
}
