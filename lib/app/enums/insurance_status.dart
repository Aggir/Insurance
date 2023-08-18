enum InsuranceStatus {
  processing,
  active,
  expire,
}

extension StringToInsuranceStatusExtension on String {
  InsuranceStatus toInsuranceStatus() {
    switch (toLowerCase()) {
      case 'processing':
        return InsuranceStatus.processing;
      case 'active':
        return InsuranceStatus.active;
      case 'expire':
      default:
        return InsuranceStatus.expire;
    }
  }
}
