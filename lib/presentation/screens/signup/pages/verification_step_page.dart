import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../blocs/signup/signup_cubit.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_form_field_date_picker.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/primary_button.dart';
import '../components/identity_verification_image.dart';
import '../components/signup_footer_row.dart';
import '../components/upload_verification_document.dart';

class SignUpVerificationStepPage extends StatefulWidget {
  const SignUpVerificationStepPage({super.key});

  @override
  State<SignUpVerificationStepPage> createState() =>
      _SignUpVerificationStepPageState();
}

class _SignUpVerificationStepPageState
    extends State<SignUpVerificationStepPage> {
  void _mainButtonFunction(BuildContext context, SignUpState state) {
    FocusScope.of(context).unfocus();
    final cubit = BlocProvider.of<SignUpCubit>(context);
    if (cubit.confirmVerificationForm()) {
      if (state.isLibyan) {
        context.go(Routes.signupNationalIdNumberStepRoute);
      } else {
        cubit.signUp();
        context.go(Routes.homeRoute);
      }
    }
  }

  bool formIsNotEmpty = false;

  void _checkIsFormEmpty(SignUpState state) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    if (state.isLibyan) {
      if (cubit.documentNumberController.text.trim().isNotEmpty &&
          cubit.documentIssuingPlaceController.text.trim().isNotEmpty &&
          cubit.documentDateOfIssueController.text.trim().isNotEmpty &&
          cubit.documentDateOfExpiryController.text.trim().isNotEmpty) {
        setState(() {
          formIsNotEmpty = true;
        });
      } else {
        setState(() {
          formIsNotEmpty = false;
        });
      }
    } else {
      if (cubit.documentNumberController.text.trim().isNotEmpty) {
        setState(() {
          formIsNotEmpty = true;
        });
      } else {
        setState(() {
          formIsNotEmpty = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIsFormEmpty(BlocProvider.of<SignUpCubit>(context).state);
  }

  void _uploadFunction(BuildContext context) {
    BlocProvider.of<SignUpCubit>(context).uploadDocumentPicture();
  }

  _removeFunction(BuildContext context) {
    BlocProvider.of<SignUpCubit>(context).removeDocumentPicture();
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
                imagePath: ImageAssets.identityVerificationPassport,
              ),
              CustomSpacers.large(),
              _headlineTextWidget(),
              CustomSpacers.medium(),
              _bodyTextWidget(),
              CustomSpacers.large(),
              SizedBox(
                height: AppSizes.s250.r,
                child: SingleChildScrollView(
                  child: Column(children: [
                    BlocBuilder<SignUpCubit, SignUpState>(
                      builder: (context, state) {
                        bool isPassport =
                            state.verificationType == AppStrings.passport.tr();
                        if (isPassport) {
                          return UploadDocument(
                            uploadFileStatus: state.verificationDocumentStatus,
                            uploadFunction: () => _uploadFunction(context),
                            removeFunction: () => _removeFunction(context),
                          );
                        } else {
                          return UploadDocument(
                            uploadFileStatus: state.verificationDocumentStatus,
                            uploadStateText:
                                AppStrings.uploadIdCardPicture.tr(),
                            loadingAndSuccessStateText:
                                AppStrings.idCardPicture.tr(),
                            uploadedDocumentSvgPath: SvgAssets.idCard,
                            uploadFunction: () => _uploadFunction(context),
                            removeFunction: () => _removeFunction(context),
                          );
                        }
                      },
                    ),
                    CustomSpacers.medium(),
                    _documentInfoForm(),
                  ]),
                ),
              ),
              const Spacer(),
              _mainButton(context),
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

  Widget _documentInfoForm() {
    final cubit = BlocProvider.of<SignUpCubit>(context);

    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        bool isPassport = state.verificationType == AppStrings.passport.tr();
        return Form(
          key: cubit.verificationForm,
          onChanged: () => _checkIsFormEmpty(state),
          child: Column(
            children: [
              CustomTextFormField(
                controller: cubit.documentNumberController,
                hintText: isPassport
                    ? AppStrings.passportNumber.tr()
                    : AppStrings.idCardNumber.tr(),
              ),
              if (state.isLibyan) ...[
                CustomSpacers.medium(),
                CustomTextFormField(
                  controller: cubit.documentIssuingPlaceController,
                  hintText: AppStrings.issuingPlace.tr(),
                ),
                CustomSpacers.medium(),
                CustomFormFieldDatePicker(
                  controller: cubit.documentDateOfIssueController,
                  hintText: AppStrings.dateOfIssue.tr(),
                ),
                CustomSpacers.medium(),
                CustomFormFieldDatePicker(
                  controller: cubit.documentDateOfExpiryController,
                  hintText: AppStrings.dateOfExpiry.tr(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 100),
                ),
              ]
            ],
          ),
        );
      },
    );
  }

  Widget _mainButton(context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return PrimaryButton.fullWidth(
          onPressed:
              (formIsNotEmpty && state.verificationDocumentStatus.isSuccess)
                  ? () => _mainButtonFunction(context, state)
                  : null,
          child: Text(
            state.isLibyan
                ? AppStrings.next.tr()
                : AppStrings.createAccount.tr(),
          ),
        );
      },
    );
  }
}
