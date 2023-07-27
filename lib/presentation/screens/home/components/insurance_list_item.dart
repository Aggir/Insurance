import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/domain/entities/insurance.dart';

class InsuranceListItem extends StatelessWidget {
  const InsuranceListItem(this.insurance, {super.key});
  final Insurance insurance;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                SvgAssets.insurance,
                width: 64.r,
              )
            ],
          )
        ],
      ),
    );
  }
}
