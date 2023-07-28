import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/assets_manager.dart';

import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/primary_button.dart';
import 'package:insurance_app/presentation/widgets/secondary_button.dart';

import 'package:url_launcher/url_launcher.dart';

class InsuranceDocument extends StatefulWidget {
  const InsuranceDocument(this.referenceNumber, {super.key});
  final String referenceNumber;

  @override
  State<InsuranceDocument> createState() => _InsuranceDocumentState();
}

class _InsuranceDocumentState extends State<InsuranceDocument> {
  final String pdfUrlString =
      'https://static.aviva.io/content/dam/aviva-public/gb/pdfs/personal/insurance/motor/car/insurance_motor_car_motor_policy_booklet_241017_NMDMG10249_v3.pdf';
  late final Uri pdfUrlUri;

  bool _isLoading = true;
  late PDFDocument _document;
  late PDFPage _firstPage;

  @override
  void initState() {
    super.initState();
    pdfUrlUri = Uri.parse(pdfUrlString);
    loadDocument();
  }

  loadDocument() async {
    _document = await PDFDocument.fromURL(pdfUrlString);
    _firstPage = await _document.get(page: 1);
    setState(() {
      _isLoading = false;
    });
  }

  void _openDocument(BuildContext context) async {
    // For now it opens the browser and by default the browser(Google Chrome) automatically downloads the pdf and then u can open the pdf with external app.
    // Todo: open it with external app without using the browser.
    if (await canLaunchUrl(pdfUrlUri)) {
      await launchUrl(pdfUrlUri, mode: LaunchMode.externalApplication);
    }
  }

  void _downloadDocument(BuildContext context) async {
    // For now it opens the browser and by default the browser(Google Chrome) automatically downloads the pdf
    // Todo: download it within the app without using the browser.
    if (await canLaunchUrl(pdfUrlUri)) {
      await launchUrl(pdfUrlUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        customTitle: Text.rich(
          TextSpan(
            text: '${AppStrings.document.tr()} ',
            style: smallHeadlineStyle(),
            children: [
              TextSpan(
                text: widget.referenceNumber,
                style: smallGrayHeadlineStyle(),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppValues.mediumLarge, vertical: AppValues.extraLarge),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(AppValues.smallRadius)),
              height: AppSizes.s270.r,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.topCenter,
                // fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                                  horizontal: AppValues.extraLarge)
                              .r,
                          child: Image.file(
                            File(_firstPage.imgPath!),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                  Positioned(
                    bottom: AppSizes.s16.r,
                    left: AppSizes.s24.r,
                    child: SecondaryButton(
                      onPressed:
                          _isLoading ? null : () => _openDocument(context),
                      child: SvgPicture.asset(
                        SvgAssets.expand,
                        height: AppSizes.s24.r,
                        width: AppSizes.s24.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            PrimaryButton.fullWidth(
                child: Text(
                  AppStrings.download.tr().toUpperCase(),
                ),
                onPressed: _isLoading ? null : () => _downloadDocument(context))
          ],
        ),
      ),
    );
  }
}
