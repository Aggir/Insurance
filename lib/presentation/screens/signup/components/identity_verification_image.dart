import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/assets_manager.dart';

class IdentityVerificationImage extends StatelessWidget {
  const IdentityVerificationImage({required this.imagePath, super.key});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SvgPicture.asset(
            SvgAssets.identityVerificationPassport,
            height: 104,
            width: 104,
          ),
        ),
        Center(
          child: SizedBox(
            height: 104,
            width: 104,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                imagePath,
                width: 86,
                height: 86,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
