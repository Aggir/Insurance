import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:insurance_app/domain/entities/vehicle_brand.dart';
import 'package:insurance_app/presentation/blocs/add_my_vehicle/add_my_vehicle_cubit.dart';
import 'package:insurance_app/presentation/theme/app_colors.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/custom_text_form_field.dart';

class CarBrandModal extends StatelessWidget {
  const CarBrandModal({
    Key? key,
    required this.vehicleBrands,
  }) : super(key: key);
  final List<VehicleBrandEntity> vehicleBrands;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        top: AppValues.extraLarge,
        left: AppValues.mediumLarge,
        right: AppValues.mediumLarge,
        bottom: AppValues.mediumLarge,
      ).r,
      children: [
        Text(
          AppStrings.selectOrSearchForYourVehicleType.tr(),
          style: largeHeadlineStyle(),
          textAlign: TextAlign.center,
        ),
        CustomSpacers.medium(),
        CustomTextFormField(
          hintText: AppStrings.search.tr(),
          prefixIcon: SvgPicture.asset(
            SvgAssets.search,
            height: AppSizes.s24.r,
            width: AppSizes.s24.r,
            fit: BoxFit.fill,
          ),
        ),
        CustomSpacers.extraLarge(),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: AppSizes.s80.r / AppSizes.s104.r,
            mainAxisSpacing: AppValues.mediumSmall.r,
            crossAxisSpacing: AppValues.mediumSmall.r,
          ),
          itemCount: vehicleBrands.length,
          itemBuilder: (context, index) =>
              _gridViewItem(vehicleBrands[index], context),
        )
      ],
    );
  }

  Widget _gridViewItem(VehicleBrandEntity item, BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AddMyVehicleCubit>(context).setVehicleBrand(item);
        context.pop();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(AppValues.small).r,
            height: AppSizes.s80.r,
            width: AppSizes.s80.r,
            decoration: BoxDecoration(
              color: AppColors.lightest,
              border: Border.all(color: AppColors.grayLight),
              borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
            ),
            child: CachedNetworkImage(
              imageUrl: item.icon,
            ),
          ),
          CustomSpacers.small(),
          Text(item.name)
        ],
      ),
    );
  }
}
