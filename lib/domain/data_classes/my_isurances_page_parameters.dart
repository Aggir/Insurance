class MyInsurancesPageParameters {
  final int pageIndex;
  final bool isPaymentModalShown;
  final int? selectedInsuranceId;
  const MyInsurancesPageParameters({
    this.pageIndex = 0,
    this.isPaymentModalShown = false,
    this.selectedInsuranceId,
  });
}
