import 'package:insurance_app/domain/entities/payment_method.dart';

class PaymentStepParameters {
  final PaymentMethod paymentMethod;
  final int insuranceId;
  PaymentStepParameters({
    required this.paymentMethod,
    required this.insuranceId,
  });
}
