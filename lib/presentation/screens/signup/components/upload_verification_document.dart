import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';

import '../../../theme/text_style_manager.dart';

class UploadDocument extends StatelessWidget {
  const UploadDocument({
    required this.uploadFileStatus,
    this.uploadStateText,
    this.removeFunction,
    this.uploadFunction,
    this.loadingAndSuccessStateText,
    this.uploadedDocumentSvgPath,
    super.key,
  });
  final UploadFileStatus uploadFileStatus;
  final void Function()? uploadFunction;
  final void Function()? removeFunction;
  final String? uploadStateText;
  final String? loadingAndSuccessStateText;
  final String? uploadedDocumentSvgPath;

  @override
  Widget build(BuildContext context) {
    if (uploadFileStatus.isLoading) {
      return _uploadDocumentOnprogressState(context);
    } else if (uploadFileStatus.isSuccess) {
      return _uploadedDocumentState(context);
    } else {
      return _selectDocumentState(context);
    }
  }

  Widget _selectDocumentState(BuildContext context) {
    return Material(
      color: AppColors.lightest,
      borderRadius: BorderRadius.circular(AppValues.inputRadius),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: AppSizes.s180,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grayLight),
          borderRadius: BorderRadius.circular(AppValues.inputRadius),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: uploadFunction,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              SvgAssets.uploadDocument,
              height: AppSizes.s40,
              width: AppSizes.s40,
            ),
            const SizedBox(height: AppSizes.s10, width: AppSizes.s10),
            Text(uploadStateText ?? AppStrings.uploadPassportPicture.tr(),
                style: headlineSmallStyle()),
            const SizedBox(height: AppSizes.s10, width: AppSizes.s10),
            Text(
              AppStrings.passportPictureSupportedExtensions.tr(),
              style: smallGrayBodyStyle(),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _uploadDocumentOnprogressState(BuildContext context) {
    return _selectedDocumentContainer(
      children: [
        SvgPicture.asset(
          SvgAssets.uploadDocument,
          height: AppSizes.s60,
          width: AppSizes.s60,
        ),
        const SizedBox(
          height: AppSizes.s10,
          width: AppSizes.s10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              loadingAndSuccessStateText ?? AppStrings.passportPicture.tr(),
              style: headlineSmallStyle(),
            ),
            Text(
              'File_name.pdf',
              style: smallGrayBodyStyle(),
            ),
            SizedBox(
              width: AppSizes.s200,
              child: LinearProgressIndicator(
                backgroundColor: AppColors.primaryLight,
                minHeight: AppSizes.s8,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _uploadedDocumentState(BuildContext context) {
    return _selectedDocumentContainer(
      children: [
        SvgPicture.asset(
          uploadedDocumentSvgPath ?? SvgAssets.uploadedDocument,
          height: AppSizes.s60,
          width: AppSizes.s60,
        ),
        const SizedBox(
          height: AppSizes.s10,
          width: AppSizes.s10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              loadingAndSuccessStateText ?? AppStrings.passportPicture.tr(),
              style: headlineSmallStyle(),
            ),
            Text(
              'File_name.pdf',
              style: smallGrayBodyStyle(),
            ),
          ],
        ),
        const Spacer(),
        Material(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(100),
          clipBehavior: Clip.antiAlias,
          child: IconButton(
            onPressed: removeFunction,
            icon: Icon(Icons.close, color: AppColors.gray),
          ),
        )
      ],
    );
  }

  Widget _selectedDocumentContainer({required List<Widget> children}) {
    return Container(
      height: AppSizes.s100,
      padding: const EdgeInsets.all(AppValues.medium),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grayLight),
        borderRadius: BorderRadius.circular(AppValues.inputRadius),
        boxShadow: [AppValues.boxShadow],
      ),
      child: Row(
        children: children,
      ),
    );
  }
}
