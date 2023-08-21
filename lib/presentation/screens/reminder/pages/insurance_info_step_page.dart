import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/status_enum.dart';

import 'package:insurance_app/presentation/blocs/add_reminder/add_reminder_cubit.dart';
import 'package:insurance_app/presentation/screens/reminder/components/reminder_dialog.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';
import 'package:insurance_app/presentation/widgets/identity_verification_image.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/presentation/widgets/snackBars.dart';

import '../../../../app/router/routes.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/page_content_padding.dart';
import '../../../widgets/select_document.dart';

class ReminderInsuranceInfoStepPage extends StatelessWidget {
  const ReminderInsuranceInfoStepPage({super.key});

  void _uploadFunction(BuildContext context) {
    BlocProvider.of<AddReminderCubit>(context).uploadInsurancePicture();
  }

  void _removeFunction(BuildContext context) {
    BlocProvider.of<AddReminderCubit>(context).removeInsurancePicture();
  }

  void _activateButtonFunction(BuildContext context) {
    DialogService.loadLoadingDialog(context);
    BlocProvider.of<AddReminderCubit>(context).addReminder();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
      height: MediaQuery.of(context).size.height -
          AppValues.appBarHeight.r -
          AppSizes.s30.r,
      child: PageContentPadding(
        child: Column(
          children: [
            const FramedImage(imagePath: ImageAssets.issuing),
            CustomSpacers.large(),
            Text(
              AppStrings.insurancePicture.tr(),
              style: largeHeadlineStyle(),
            ),
            CustomSpacers.medium(),
            Text(
              AppStrings.pleaseAttachACopyOfTheInsuranceToBeReminded.tr(),
              style: darkGrayBodyStyle(),
            ),
            CustomSpacers.extraLarge(),
            SizedBox(
              height: AppSizes.s250.r,
              child: SingleChildScrollView(
                child: Column(children: [
                  BlocConsumer<AddReminderCubit, AddReminderState>(
                    listenWhen: (previous, current) =>
                        previous.addReminderStatus != current.addReminderStatus,
                    listener: (context, state) {
                      if (state.addReminderStatus.isFailure) {
                        DialogService.dispose();
                        SnackBars.error(
                            context, state.addReminderErrorMessage!);
                      } else if (state.addReminderStatus.isSuccess) {
                        DialogService.dispose();
                        context.go(AppScreen.home.toPath,
                            extra: const ReminderDialog());
                      }
                    },
                    builder: (context, state) {
                      return SelectDocument(
                        selectFileStatus: state.insurancePictureStatus,
                        selectStateText: AppStrings.uploadInsurancePicture.tr(),
                        loadingAndSuccessStateText:
                            AppStrings.insurancePicture.tr(),
                        selectedDocumentSvgPath: SvgAssets.shield,
                        selectedDocumentSvgColor: AppColors.secondary,
                        filename: state.insurancePictureName,
                        uploadFunction: () => _uploadFunction(context),
                        removeFunction: () => _removeFunction(context),
                      );
                    },
                  ),
                  CustomSpacers.medium(),
                ]),
              ),
            ),
            const Spacer(),
            BlocBuilder<AddReminderCubit, AddReminderState>(
              builder: (context, state) {
                return PrimaryButton.fullWidth(
                  onPressed: state.insurancePictureStatus.isSuccess
                      ? () => _activateButtonFunction(context)
                      : null,
                  child: Text(AppStrings.activate.tr()),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
