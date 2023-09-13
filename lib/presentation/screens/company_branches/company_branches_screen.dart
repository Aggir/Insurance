import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/entities/branch.dart';
import 'package:insurance_app/presentation/blocs/company_branches/company_branches_cubit.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/theme/text_style_manager.dart';
import 'package:insurance_app/presentation/widgets/custom_app_bar.dart';
import 'package:insurance_app/presentation/widgets/custom_drop_down_field.dart';
import 'package:insurance_app/presentation/widgets/custom_spacers.dart';
import 'package:insurance_app/presentation/widgets/snackbars.dart';
import 'package:latlong2/latlong.dart';

import '../../widgets/dialog_service.dart';

class CompanyBranchesScreen extends StatefulWidget {
  const CompanyBranchesScreen(this.companyId, {super.key});
  final String? companyId;

  @override
  State<CompanyBranchesScreen> createState() => _CompanyBranchesScreenState();
}

class _CompanyBranchesScreenState extends State<CompanyBranchesScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance
        .addPostFrameCallback((_) => DialogService.loadLoadingDialog(context));
    BlocProvider.of<CompanyBranchesCubit>(context)
        .fetchCompanyBranches(int.parse(widget.companyId!));
  }

  MapController mapController = MapController();
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
              BlocConsumer<CompanyBranchesCubit, CompanyBranchesState>(
                listener: (context, state) {
                  if (state.fetchBranchesStatus.isFailure) {
                    DialogService.dispose();
                    SnackBars.error(context, state.fetchBranchesErrorMessage!);
                  } else if (state.fetchBranchesStatus.isSuccess) {
                    DialogService.dispose();
                  }
                },
                builder: (context, state) {
                  return FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                        maxZoom: 18.4,
                        center: const LatLng(
                            32.890683754591706, 13.192910130704213)),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'dev.fleaflet.flutter_map.example',
                      ),
                      MarkerLayer(
                        markers: [
                          if (state.branches != null)
                            ...state.branches!
                                .map((e) => _mapMarker(e.lat, e.lng))
                                .toList()
                        ],
                      ),
                    ],
                  );
                },
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
                      BlocBuilder<CompanyBranchesCubit, CompanyBranchesState>(
                        builder: (context, state) {
                          return CustomDropDownField(
                            onChanged: (value) {
                              if (value is BranchEntity) {
                                mapController.move(
                                    LatLng(value.lat, value.lng), 13);
                              }
                            },
                            hintText: AppStrings.selectCity.tr(),
                            defaultValidator: false,
                            items: state.branches == null
                                ? []
                                : state.branches!
                                    .map(
                                      (branch) => DropdownMenuItem(
                                        value: branch,
                                        child: Text(
                                          branch.name,
                                          style: bodyStyle(),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          );
                        },
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

  Marker _mapMarker(double lat, double lng) {
    return Marker(
      width: AppSizes.s24.r,
      height: AppSizes.s24.r,
      point: LatLng(lat, lng),
      builder: (ctx) => CircleAvatar(
        backgroundColor: AppColors.primary,
        child: CircleAvatar(
          radius: AppSizes.s6.r,
          backgroundColor: AppColors.white,
        ),
      ),
    );
  }
}
