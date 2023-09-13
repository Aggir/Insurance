import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/app/router/routes.dart';
import 'package:insurance_app/presentation/blocs/add_my_vehicle/add_my_vehicle_cubit.dart';
import 'package:insurance_app/presentation/screens/add_my_vehicle/components/vehicle_success_dialog.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';
import 'package:insurance_app/presentation/widgets/dialog_service.dart';

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
import '../../../widgets/select_document.dart';
import '../../../widgets/snackbars.dart';

class AddMyVehiclePictureStepPage extends StatefulWidget {
  const AddMyVehiclePictureStepPage({super.key});

  @override
  State<AddMyVehiclePictureStepPage> createState() =>
      _AddMyVehiclePictureStepPageState();
}

class _AddMyVehiclePictureStepPageState
    extends State<AddMyVehiclePictureStepPage> {
  final ScrollController scrollController = ScrollController();

  void _mainButtonFunction(BuildContext context, AddMyVehicleState state) {
    FocusScope.of(context).unfocus();
    final cubit = BlocProvider.of<AddMyVehicleCubit>(context);

    if (cubit.isVehiclePictureFormValid()) {
      DialogService.loadLoadingDialog(context);
      cubit.addVehicle();
    }
    if (state.selectedVehicleCityId == null) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 150), curve: Curves.bounceIn);
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
              child: BlocListener<AddMyVehicleCubit, AddMyVehicleState>(
                listenWhen: (previous, current) =>
                    previous.addVehicleStatus != current.addVehicleStatus,
                listener: (context, state) {
                  if (state.addVehicleStatus.isFailure) {
                    DialogService.dispose();
                    SnackBars.error(context, state.addVehicleErrorMessage!);
                  } else if (state.addVehicleStatus.isSuccess) {
                    DialogService.dispose();
                    context.go(
                      AppScreen.home.toPath,
                      extra: const VehicleSuccessDialog(),
                    );
                  }
                },
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
                        SizedBox(
                          height: AppSizes.s320.r,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                BlocBuilder<AddMyVehicleCubit,
                                    AddMyVehicleState>(
                                  builder: (context, state) {
                                    return SelectDocument(
                                      filename: state.vehiclePictureFileName,
                                      selectFileStatus:
                                          state.vehiclePictureStatus,
                                      selectStateText:
                                          AppStrings.uploadVehiclePicture.tr(),
                                      loadingAndSuccessStateText:
                                          AppStrings.vehiclePicture.tr(),
                                      selectedDocumentSvgPath: SvgAssets.car,
                                      selectedDocumentSvgColor:
                                          AppColors.secondary,
                                      uploadFunction: () =>
                                          _uploadFunction(context),
                                      removeFunction: () =>
                                          _removeFunction(context),
                                    );
                                  },
                                ),
                                CustomSpacers.medium(),
                                _form(),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        _saveButton(context),
                      ],
                    ),
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
                controller: cubit.vehicleAliasController,
                hintText: AppStrings.alias.tr(),
                defaultValidator: false,
              ),
              CustomSpacers.medium(),
              CustomTextFormField(
                controller: cubit.vehicleLicensePlateNumberController,
                hintText: AppStrings.licensePlateNumber.tr(),
              ),
              CustomSpacers.medium(),
              CustomDropDownField(
                onChanged: (value) => cubit.setVehicleCityId(int.parse(value)),
                hintText: AppStrings.registeredAuthority.tr(),
                items: state.cities == null
                    ? []
                    : state.cities!
                        .map(
                          (city) => DropdownMenuItem(
                            value: city.id.toString(),
                            child: Text(
                              city.name,
                              style: bodyStyle(),
                            ),
                          ),
                        )
                        .toList(),
              ),
              CustomSpacers.medium(),
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
          onPressed: state.vehiclePictureFile != null
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
