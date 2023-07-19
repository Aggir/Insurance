import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';

import '../../../theme/text_style_manager.dart';

class UploadVerificationDocument extends StatelessWidget {
  const UploadVerificationDocument({
    this.isPassport = true,
    this.onTap,
    super.key,
  });
  final bool isPassport;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return _uploadedDocumentState();
  }

  Widget _selectDocumentState() {
    return Material(
      color: AppColors.lightPastelBlue,
      borderRadius: BorderRadius.circular(AppValues.inputRadius),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: AppSizes.s180,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGray),
          borderRadius: BorderRadius.circular(AppValues.inputRadius),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              SvgAssets.uploadDocument,
              height: AppSizes.s40,
              width: AppSizes.s40,
            ),
            const SizedBox(height: AppSizes.s10, width: AppSizes.s10),
            Text(isPassport ? AppStrings.uploadPassportPicture : "ADD",
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

  Widget _uploadDocumentOnprogressState() {
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
              isPassport ? AppStrings.passportPicture : " ee",
              style: headlineSmallStyle(),
            ).tr(),
            Text(
              'File_name.pdf',
              style: smallGrayBodyStyle(),
            ).tr(),
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

  Widget _uploadedDocumentState() {
    return _selectedDocumentContainer(
      children: [
        SvgPicture.asset(
          SvgAssets.uploadedDocument,
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
              isPassport ? AppStrings.passportPicture : " ee",
              style: headlineSmallStyle(),
            ).tr(),
            Text(
              'File_name.pdf',
              style: smallGrayBodyStyle(),
            ).tr(),
          ],
        ),
        const Spacer(),
        Material(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(100),
          clipBehavior: Clip.antiAlias,
          child: IconButton(
            onPressed: () {},
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
        border: Border.all(color: AppColors.lightGray),
        borderRadius: BorderRadius.circular(AppValues.inputRadius),
        boxShadow: [AppValues.boxShadow],
      ),
      child: Row(
        children: children,
      ),
    );
  }
}
