import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums/proof_type.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/data_classes/proof_document.dart';

import 'package:insurance_app/presentation/blocs/user/user_cubit.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/page_content_padding.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../../app/router/routes.dart';
import '../../../blocs/sign_up/sign_up_cubit.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_form_field_date_picker.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/identity_verification_image.dart';
import '../components/signup_footer_row.dart';
import '../../../widgets/select_document.dart';

class SignUpProofInfoStepPage extends StatefulWidget {
  const SignUpProofInfoStepPage({super.key});

  @override
  State<SignUpProofInfoStepPage> createState() =>
      _SignUpProofInfoStepPageState();
}

class _SignUpProofInfoStepPageState extends State<SignUpProofInfoStepPage> {
  void _mainButtonFunction(BuildContext context, SignUpState state) async {
    FocusScope.of(context).unfocus();
    final signUpCubit = BlocProvider.of<SignUpCubit>(context);
    final userCubit = BlocProvider.of<UserCubit>(context);
    if (signUpCubit.proofInfoForm.currentState?.validate() ?? false) {
      DialogService.loadLoadingDialog(context);
      if (state.isLibyan) {
        bool isFormValid = await signUpCubit.confirmProofInfoForm();
        if (isFormValid) {
          signUpCubit.confirmProofInfoForm();
        }
      } else {
        userCubit.signUp(
          signUpCubit.state.userInfo!,
          signUpCubit.state.password!,
          signUpCubit.state.isLibyan,
          ProofDocument(
            proofType: state.proofType!,
            proofFile: state.proofFile!,
            proofId: signUpCubit.documentNumberController.text.trim(),
            issuePlace: signUpCubit.documentIssuingPlaceController.text.trim(),
            issueDate: signUpCubit.documentDateOfIssueController.text.trim(),
            expirationDate:
                signUpCubit.documentDateOfExpiryController.text.trim(),
          ),
        );
        // context.go(AppScreen.homeRoute, extra: const FirstLoginDialog());
      }
    }
  }

  bool formIsNotEmpty = false;

  void _checkIsFormEmpty(SignUpState state) {
    final cubit = BlocProvider.of<SignUpCubit>(context);

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
  }

  @override
  void initState() {
    super.initState();
    _checkIsFormEmpty(BlocProvider.of<SignUpCubit>(context).state);
  }

  void _uploadFunction(BuildContext context) {
    BlocProvider.of<SignUpCubit>(context).uploadVerificationDocument();
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
            AppValues.appBarHeight.r -
            AppSizes.s30.r,
        child: BlocListener<UserCubit, UserState>(
          listenWhen: (previous, current) =>
              previous.authStatus != current.authStatus,
          listener: (context, state) {
            if (state.authStatus.isFailure) {
              DialogService.dispose();
              SnackBars.error(context, state.authErrorMessage!);
            } else if (state.authStatus.isSuccess) {
              DialogService.dispose();
            }
          },
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
                SizedBox(
                  height: AppSizes.s250.r,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      BlocConsumer<SignUpCubit, SignUpState>(
                        listenWhen: (previous, current) =>
                            previous.checkProofId != current.checkProofId,
                        listener: (context, state) {
                          if (state.isLibyan) {
                            if (state.checkProofId.isFailure) {
                              DialogService.dispose();
                              SnackBars.error(
                                  context, state.checkProofIdErrorMessage!);
                            } else if (state.checkProofId.isSuccess) {
                              DialogService.dispose();
                              context
                                  .go(AppScreen.signupNationalInfoStep.toPath);
                            }
                          }
                        },
                        builder: (context, state) {
                          bool isPassport = state.proofType.isPassport;
                          if (isPassport) {
                            return SelectDocument(
                              selectFileStatus: state.proofStatus,
                              uploadFunction: () => _uploadFunction(context),
                              removeFunction: () => _removeFunction(context),
                              filename: state.proofFileName,
                            );
                          } else {
                            return SelectDocument(
                              selectFileStatus: state.proofStatus,
                              selectStateText:
                                  AppStrings.uploadIdCardPicture.tr(),
                              loadingAndSuccessStateText:
                                  AppStrings.idCardPicture.tr(),
                              selectedDocumentSvgPath: SvgAssets.idCard,
                              uploadFunction: () => _uploadFunction(context),
                              removeFunction: () => _removeFunction(context),
                              filename: state.proofFileName,
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
        bool isPassport = state.proofType.isPassport;
        return Form(
          key: cubit.proofInfoForm,
          onChanged: () => _checkIsFormEmpty(state),
          child: Column(
            children: [
              CustomTextFormField(
                controller: cubit.documentNumberController,
                hintText: isPassport
                    ? AppStrings.passportNumber.tr()
                    : AppStrings.idCardNumber.tr(),
              ),
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
          onPressed: (formIsNotEmpty && state.proofStatus.isSuccess)
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
