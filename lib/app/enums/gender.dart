import 'package:insurance_app/app/constants.dart';

enum Gender {
  male,
  female,
}

extension GenderExtension on Gender {
  String get asString => name.toUpperCase();
}

extension StringToGenderExtension on String? {
  Gender toGender() {
    switch (this?.toLowerCase() ?? Constants.empty) {
      case 'female':
        return Gender.female;
      case 'male':
      default:
        return Gender.male;
    }
  }
}
