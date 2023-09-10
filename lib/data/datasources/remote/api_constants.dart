class ApiConstants {
  static const String baseUrl = 'https://insurance-api-mf0n.onrender.com/api';

  static const String notifications = '/notification';
  static const String notificationToggleSeen = '/notification/toggleSeen';
  static const String notificationToggleRead = '/notification/toggleRead';
  static const String notificationCountUnseen = '/notification/countUnseen';

  static const String cities = '/cities';
  static const String colors = '/colors';
  static const String companies = '/companies';
  static const String companiesPrices = '/companies/prices';
  static const String branches = '/branches';
  // User
  static const String signup = '/signup';
  static const String signin = '/signin';
  static const String me = '/me';
  static const String logout = '/logout';
  static const String check = '/check';
  static const String checkDoc = '/checkDoc';
  static const String checkNational = '/check_national';
  static const String updateSelf = '/update_self';
  static const String changePassword = '/change_password';
  static const String deactivate = '/deactivate_self';
  static const String resetPassword = '/reset_password';
  static const String validateResetOtp = '/validate_reset_otp';
  static const String sendPhoneOtp = '/send_phone_otp';
  // Vehicle
  static const String vehicleBrands = '/vehicle_brands';
  static const String vehicleCountries = '/vehicle_countries';
  static const String vehicleModels = '/vehicle_models';
  static const String vehicleOwnershipTypes = '/vehicle_ownership_types';
  static const String vehicleTypes = '/vehicle_types';
  static const String vehicles = '/vehicles';
  static const String toggleIsVehicleHidden = '/vehicles/toggleHidden';
  // Insurance
  static const String insuranceTypes = '/insurance_types';
  static const String insurances = '/insurances';
  static const String calculateInsurancePriceByVehicle =
      '/insurances/calculateVehiclePriceWitIhVehicleId';
  static const String calculateInsurancePrice =
      '/insurances/calculateVehiclePrice';
  static const String toggleInsurance = '/insurances/toggleInsurance';
  // Alarms
  static const String alarmTypes = '/alarm_types';
  static const String alarms = '/alarms';
}
