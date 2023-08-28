import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insurance_app/app/app_strings.dart';

class ApiErrorHandler {
  static String auth(DioException error) {
    final message = error.response?.data['message'];

    if (message != null) {
      if (message.contains('invalid credentials')) {
        return AppStrings.invalidCredentials.tr();
      } else if (message.contains('The email has already been taken.')) {
        return AppStrings.theEmailHasAlreadyBeenTaken.tr();
      } else if (message.contains('The phone has already been taken.')) {
        return AppStrings.thePhoneHasAlreadyBeenTaken.tr();
      } else if (message.contains('The proof id has already been taken.')) {
        return AppStrings.theProofIdHasAlreadyBeenTaken.tr();
      } else if (message.contains('The national id has already been taken.')) {
        return AppStrings.theNationalIdHasAlreadyBeenTaken.tr();
      }
    }

    return message?.toString() ?? AppStrings.genericError.tr();
  }

  static String changePassword(DioException error) {
    final message = error.response?.data['message'];

    if (message != null) {
      if (message.contains('invalid credentials')) {
        return AppStrings.wrongCurrentPassword.tr();
      }
    }

    return message ?? AppStrings.genericError.tr();
  }

  static String generic(DioException error) {
    final message = error.response?.data['message'];

    if (message != null) {
      if (message.contains('Unauthenticated.')) {
        return AppStrings.unauthenticated.tr();
      }
    }

    return message ?? AppStrings.genericError.tr();
  }

  static String otpVerification(DioException error) {
    final message = error.response?.data['message'];

    if (message != null) {
      if (message.contains('Unauthenticated.')) {
        return AppStrings.unauthenticated.tr();
      } else if (message.contains('WRONT_OTP')) {
        return AppStrings.wrongOtp.tr();
      }
    }

    return message ?? AppStrings.genericError.tr();
  }
}
