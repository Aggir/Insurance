import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/presentation/app_router.dart';
import 'package:insurance_app/presentation/blocs/add_my_vehicle/add_my_vehicle_cubit.dart';
import 'package:insurance_app/presentation/screens/add_my_vehicle/components/vehicle_success_dialog.dart';
import 'package:insurance_app/presentation/widgets/cupertino_switch_tile.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_style_manager.dart';
import '../../../widgets/custom_drop_down_field.dart';
import '../../../widgets/custom_spacers.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/identity_verification_image.dart';
import '../../../widgets/page_content_padding.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/upload_verification_document.dart';
import 'package:insurance_app/app/dummy_data.dart' as DUMMY;

class AddMyVehiclePictureStepPage extends StatefulWidget {
  const AddMyVehiclePictureStepPage({super.key});

  @override
  State<AddMyVehiclePictureStepPage> createState() =>
      _AddMyVehiclePictureStepPageState();
}

class _AddMyVehiclePictureStepPageState
    extends State<AddMyVehiclePictureStepPage> {
  void _mainButtonFunction(BuildContext context, AddMyVehicleState state) {
    FocusScope.of(context).unfocus();
    final cubit = BlocProvider.of<AddMyVehicleCubit>(context);
    if (cubit.isVehiclePictureFormValid()) {
      context.go(Routes.homeRoute, extra: const VehicleSuccessDialog());
    }
  }

  void _uploadFunction(BuildContext context) {
    BlocProvider.of<AddMyVehicleCubit>(context).uploadVehiclePicture();
  }

  _removeFunction(BuildContext context) {
    BlocProvider.of<AddMyVehicleCubit>(context).removeVehiclePicture();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: constraints.copyWith(
                minHeight: constraints.maxHeight,
                maxHeight: double.infinity,
              ),
              child: PageContentPadding(
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const FramedImage(
                        imagePath: ImageAssets.addMyVehicleStep2,
                      ),
                      CustomSpacers.large(),
                      Text(
                        AppStrings.vehiclePicture,
                        style: largeHeadlineStyle(),
                      ).tr(),
                      CustomSpacers.medium(),
                      Text(
                        AppStrings
                            .thisInformationHelpsUsToKnowYourVehicleMoreAccurately,
                        style: darkGrayBodyStyle(),
                        textAlign: TextAlign.center,
                      ).tr(),
                      CustomSpacers.large(),
                      BlocBuilder<AddMyVehicleCubit, AddMyVehicleState>(
                        builder: (context, state) {
                          return UploadDocument(
                            uploadFileStatus: state.vehiclePictureStatus,
                            uploadStateText:
                                AppStrings.uploadVehiclePicture.tr(),
                            loadingAndSuccessStateText:
                                AppStrings.vehiclePicture.tr(),
                            uploadedDocumentSvgPath: SvgAssets.car,
                            uploadedDocumentSvgColor: AppColors.secondary,
                            uploadFunction: () => _uploadFunction(context),
                            removeFunction: () => _removeFunction(context),
                          );
                        },
                      ),
                      CustomSpacers.medium(),
                      _form(),
                      const Spacer(),
                      _saveButton(context),
                    ],
                  ),
                ),
              )));
    });
  }

  Widget _form() {
    final cubit = BlocProvider.of<AddMyVehicleCubit>(context);

    return BlocBuilder<AddMyVehicleCubit, AddMyVehicleState>(
      builder: (context, state) {
        return Form(
          key: cubit.vehiclePictureForm,
          child: Column(
            children: [
              CustomTextFormField(
                hintText: AppStrings.licensePlateNumber.tr(),
              ),
              CustomSpacers.medium(),
              CustomDropDownField(
                hintText: AppStrings.registeredAuthority.tr(),
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
              BlocBuilder<AddMyVehicleCubit, AddMyVehicleState>(
                builder: (context, state) {
                  return CupertinoSwitchTile(
                    onTap: cubit.toggleIsPublicUse,
                    text: AppStrings.publicUse.tr(),
                    value: state.isPublicUse,
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget _saveButton(context) {
    return BlocBuilder<AddMyVehicleCubit, AddMyVehicleState>(
      builder: (context, state) {
        return PrimaryButton.fullWidth(
          onPressed: state.vehiclePictureStatus.isSuccess
              ? () => _mainButtonFunction(context, state)
              : null,
          child: Text(
            AppStrings.saveVehicleFile.tr(),
          ),
        );
      },
    );
  }
}
