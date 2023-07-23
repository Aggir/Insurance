import 'package:flutter/material.dart';
import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/presentation/theme/app_theme.dart';

class DialogService {
  const DialogService._();

  static IDialog? _current;

  static Future<void> load(BuildContext context) async {
    _current = LoadDialog();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _current ?? LoadDialog(),
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
class LoadDialog extends IDialog {
  LoadDialog({super.key});

  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return AlertDialog(
      content: Image.asset(
        GifAssets.loading,
        height: AppSizes.s150,
        width: AppSizes.s150,
      ),
    );
  }

  @override
  void dismiss() {
    Navigator.pop(_context!);
  }
}
