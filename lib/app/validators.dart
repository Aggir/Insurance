import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/app_strings.dart';
import 'package:insurance_app/app/extensions.dart';

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.thisFieldIsRequired.tr();
  } else if (!value.isValidEmail()) {
    return AppStrings.invalidEmail.tr();
  } else {
    return null;
  }
}
