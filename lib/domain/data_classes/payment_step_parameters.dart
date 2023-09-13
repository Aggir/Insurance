import 'package:insurance_app/app/enums/payment_method_enum.dart';
import 'package:insurance_app/domain/entities/insurance.dart';

class PaymentStepParameters {
  final PaymentMethodEnum paymentMethod;
  final InsuranceEntity insurance;
  PaymentStepParameters({
    required this.paymentMethod,
    required this.insurance,
  });
}
