import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';

import '../../app/assets_manager.dart';

class DialogService {
  const DialogService._();

  static IDialog? _current;

  static Future<void> load(BuildContext context,
      {required Widget content, List<Widget>? actions}) async {
    _current = CustomDialog(
      content: content,
      actions: actions,
    );

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          _current ??
          CustomDialog(
            content: content,
            actions: actions,
          ),
    );
  }

  static Future<void> loadLoadingDialog(
    BuildContext context,
  ) async {
    _current = CustomDialog(
      content: Image.asset(
        GifAssets.loading,
        height: AppSizes.s150.r,
        width: AppSizes.s150.r,
      ),
    );

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          _current ??
          CustomDialog(
            content: Image.asset(
              GifAssets.loading,
              height: AppSizes.s150.r,
              width: AppSizes.s150.r,
            ),
          ),
    );
  }

  static void dispose() {
    if (_current != null) {
      _current!.dismiss();
      _current = null;
    }
  }
}

mixin IDialogService {
  void dismiss();
}

abstract class IDialog extends StatelessWidget with IDialogService {
  const IDialog({Key? key}) : super(key: key);
}

// ignore: must_be_immutable
class CustomDialog extends IDialog {
  CustomDialog({required this.content, this.actions, super.key});
  Widget content;
  List<Widget>? actions;
  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return AlertDialog(
      content: content,
      actions: actions,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppValues.largeRadius.r),
      ),
    );
  }

  @override
  void dismiss() {
    Navigator.pop(_context!);
  }
}
