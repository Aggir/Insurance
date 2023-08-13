import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';

import '../theme/text_style_manager.dart';

class SelectDocument extends StatelessWidget {
  const SelectDocument({
    required this.selectFileStatus,
    this.selectStateText,
    this.removeFunction,
    this.uploadFunction,
    this.loadingAndSuccessStateText,
    this.selectedDocumentSvgPath,
    this.selectedDocumentSvgColor,
    this.filename,
    super.key,
  });
  final Status selectFileStatus;
  final void Function()? uploadFunction;
  final void Function()? removeFunction;
  final String? selectStateText;
  final String? loadingAndSuccessStateText;
  final String? selectedDocumentSvgPath;
  final Color? selectedDocumentSvgColor;
  final String? filename;

  @override
  Widget build(BuildContext context) {
    if (selectFileStatus.isLoading) {
      return _uploadDocumentOnprogressState(context);
    } else if (selectFileStatus.isSuccess) {
      return _uploadedDocumentState(context);
    } else {
      return _selectDocumentState(context);
    }
  }

  Widget _selectDocumentState(BuildContext context) {
    return Material(
      color: AppColors.lightest,
      borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: AppSizes.s180.r,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grayLight),
          borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: uploadFunction,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              SvgAssets.uploadDocument,
              height: AppSizes.s40.r,
              width: AppSizes.s40.r,
            ),
            CustomSpacers.small(),
            Text(selectStateText ?? AppStrings.uploadPassportPicture.tr(),
                style: smallDarkGrayHeadlineStyle()),
            CustomSpacers.small(),
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
          height: AppSizes.s60.r,
          width: AppSizes.s60.r,
        ),
        CustomSpacers.small(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              loadingAndSuccessStateText ?? AppStrings.passportPicture.tr(),
              style: smallDarkGrayHeadlineStyle(),
            ),
            SizedBox(
              width: AppSizes.s200.r,
              child: LinearProgressIndicator(
                backgroundColor: AppColors.primaryLight,
                minHeight: AppSizes.s8.r,
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
          selectedDocumentSvgPath ?? SvgAssets.uploadedDocument,
          height: AppSizes.s60.r,
          width: AppSizes.s60.r,
          colorFilter: selectedDocumentSvgColor != null
              ? ColorFilter.mode(selectedDocumentSvgColor!, BlendMode.srcIn)
              : null,
        ),
        CustomSpacers.small(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              loadingAndSuccessStateText ?? AppStrings.passportPicture.tr(),
              style: smallDarkGrayHeadlineStyle(),
            ),
            SizedBox(
              width: AppSizes.s180.r,
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                filename ?? Constants.empty,
                style: smallGrayBodyStyle(),
              ),
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
      height: AppSizes.s100.r,
      padding: const EdgeInsets.all(AppValues.medium).r,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grayLight),
        borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
        boxShadow: [AppValues.boxShadow],
      ),
      child: Row(
        children: children,
      ),
    );
  }
}
