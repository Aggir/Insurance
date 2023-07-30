import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_drop_down_field.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;
import 'package:latlong2/latlong.dart';

class CompanyBranchesScreen extends StatefulWidget {
  const CompanyBranchesScreen(this.companyId, {super.key});
  final String? companyId;

  @override
  State<CompanyBranchesScreen> createState() => _CompanyBranchesScreenState();
}

class _CompanyBranchesScreenState extends State<CompanyBranchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBar.basic(
              title: AppStrings.branches.tr(),
              backButtonColor: AppColors.white),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                    center: LatLng(32.890683754591706, 13.192910130704213)),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                          width: AppSizes.s24.r,
                          height: AppSizes.s24.r,
                          point: const LatLng(
                              32.890683754591706, 13.192910130704213),
                          builder: (ctx) => CircleAvatar(
                                backgroundColor: AppColors.primary,
                                child: CircleAvatar(
                                  radius: AppSizes.s6.r,
                                  backgroundColor: AppColors.white,
                                ),
                              )),
                      Marker(
                        width: 80,
                        height: 80,
                        point: const LatLng(53.3498, -6.2603),
                        builder: (ctx) => const FlutterLogo(
                          textColor: Colors.green,
                          key: ObjectKey(Colors.green),
                        ),
                      ),
                      Marker(
                        width: 80,
                        height: 80,
                        point: const LatLng(48.8566, 2.3522),
                        builder: (ctx) => const FlutterLogo(
                          textColor: Colors.purple,
                          key: ObjectKey(Colors.purple),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.mediumLarge,
                    vertical: AppValues.extraLarge,
                  ).r,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.chooseOrSearchForTheNearestBranchToYou.tr(),
                        style: largeHeadlineStyle(),
                      ),
                      CustomSpacers.extraLarge(),
                      CustomDropDownField(
                        hintText: AppStrings.selectCity.tr(),
                        items: DUMMY.cities
                            .map(
                              (type) => DropdownMenuItem(
                                value: type['value'],
                                child: Text(
                                  type['value'] ?? '',
                                  style: bodyStyle(),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
