import 'package:insurance_app/domain/entities/insurance.dart';

class MyInsurancesPageParameters {
  final int pageIndex;
  final bool isPaymentModalShown;
  final InsuranceEntity? selectedInsurance;
  const MyInsurancesPageParameters({
    this.pageIndex = 0,
    this.isPaymentModalShown = false,
    this.selectedInsurance,
  });
}
