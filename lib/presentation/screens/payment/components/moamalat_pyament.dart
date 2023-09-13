import 'package:flutter/material.dart';
import 'package:insurance_app/presentation/services/moamalat_payment/src/moamalat_payment.dart';

class MoamalatPaymentMethod extends StatelessWidget {
  const MoamalatPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return MoamalatPayment(
      isTest:
          true, // Test SDK Mode - if you are working on production make it false
      merchantId: "10081014649", // put your merchantId
      merchantReference: "PS_Merchant",
      terminalId: "99179395", // put your terminalId
      amount:
          "1000", // get your amount from previous screen  Note: required  Integer number without any comma *1000
      //ex 1: if you need to recharge 10 dinnar  the amount will be 10 *1000
      //ex 2: if you need to recharge 10.5 dinnar the amount will be 10500
      merchantSecretKey:
          "39636630633731362D663963322D346362642D386531662D633963303432353936373431", //put your merchantSecretKey
      // * make sure all value's are String *
      onCompleteSuccess: (value) {
        print(value);
      },
      onError: (error) {
        print(error);
        // print(error.)
      },
    );
  }
}
