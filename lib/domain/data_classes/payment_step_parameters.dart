import 'package:insurance_app/domain/entities/insurance.dart';
import 'package:insurance_app/domain/entities/payment_method.dart';

class PaymentStepParameters {
  final PaymentMethod paymentMethod;
  final InsuranceEntity insurance;
  PaymentStepParameters({
    required this.paymentMethod,
    required this.insurance,
  });
}
