import 'package:flutter/services.dart';

class MoamalatPayment {
  static const platform = MethodChannel('moamalat');
  static const String PAYMENT_METHOD = 'mobicash_payment';
  static Future<void> getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    print(batteryLevel);
  }

  Future<void> _makePayment() async {
    try {
      // // pass the payment details as arguments to the native method
      // final String result = await platform
      //     .invokeMethod(PAYMENT_METHOD, {'amount': _amount, 'phone': _phone});
      // // update the result variable with the response from the native code
      // print(result);
    } on PlatformException catch (e) {
      // handle any errors from the native code
      print(e);
    }
  }
}
