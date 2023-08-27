enum AppScreen {
  onboarding,
  termsAndConditions,
  loading,
  login,
  signup,
  signupPasswordStep,
  signupSelectProofTypeStep,
  signupProofInfoStep,
  signupNationalInfoStep,
  forgotPassword,
  forgotPasswordVerifyOtpStep,
  forgotPasswordResetStep,
  myPayments,
  settings,
  changePassword,
  profile,
  addMyVehicle,
  addMyVehicleDetailsStepOne,
  addMyVehicleDetailsStepTwo,
  addMyVehiclePictureStep,
  payment,
  paymentVerifyOtpStep,
  issueInsurance,
  issueInstallmentDetails,
  reminder,
  reminderInsuranceInfoStep,
  comparePrices,
  companies,
  companyDetails,
  companyBranches,
  notifications,
  carsInsurance,
  noConnection,
  home,
  myVehicles,
  myHiddenVehicles,
  myInsurances,
  insuranceDocument,
  more,
  myAlarms
}

extension AppScreenExtension on AppScreen {
  String get toPath {
    switch (this) {
      case AppScreen.onboarding:
        return "/start";
      case AppScreen.termsAndConditions:
        return "/terms-and-conditions";
      case AppScreen.loading:
        return "/loading";
      case AppScreen.login:
        return "/login";
      case AppScreen.signup:
        return "/signup";
      case AppScreen.signupPasswordStep:
        return "/signup-password-step";
      case AppScreen.signupSelectProofTypeStep:
        return "/signup-select-proof-type-step";
      case AppScreen.signupProofInfoStep:
        return "/signup-proof-info-step";
      case AppScreen.signupNationalInfoStep:
        return "/signup-national-info-step";
      case AppScreen.forgotPassword:
        return "/forgot-password";
      case AppScreen.forgotPasswordVerifyOtpStep:
        return "/forgot_password_verify_otp_step";
      case AppScreen.forgotPasswordResetStep:
        return "/forgot-password-reset-step";
      case AppScreen.myPayments:
        return "/my-payments";
      case AppScreen.settings:
        return "/settings";
      case AppScreen.changePassword:
        return "/settings/change-password";
      case AppScreen.profile:
        return "/profile";
      case AppScreen.addMyVehicle:
        return "/add-my-vehicle";
      case AppScreen.addMyVehicleDetailsStepOne:
        return "/add-my-vehicle-details-step-one";
      case AppScreen.addMyVehicleDetailsStepTwo:
        return "/add-my-vehicle-details-step-two";
      case AppScreen.addMyVehiclePictureStep:
        return "/add-my-vehicle-picture-step";
      case AppScreen.payment:
        return "/payment";
      case AppScreen.paymentVerifyOtpStep:
        return "/payment-verify-otp-step";
      case AppScreen.issueInsurance:
        return "/issue-insurance";
      case AppScreen.issueInstallmentDetails:
        return "/issue-installment-details";
      case AppScreen.reminder:
        return "/reminder";
      case AppScreen.reminderInsuranceInfoStep:
        return "/reminder-insurance-info-step";
      case AppScreen.comparePrices:
        return "/compare-prices";
      case AppScreen.companies:
        return "/companies";
      case AppScreen.companyDetails:
        return "/companies/company";
      case AppScreen.notifications:
        return "/notifications";
      case AppScreen.carsInsurance:
        return "/cars-insurance";
      case AppScreen.noConnection:
        return "/no-connection";
      case AppScreen.home:
        return "/home";
      case AppScreen.myVehicles:
        return "/my-vehicles";
      case AppScreen.myHiddenVehicles:
        return "/my-hidden-vehicles";
      case AppScreen.myInsurances:
        return "/my-insurances";
      case AppScreen.insuranceDocument:
        return "/insurance-document";
      case AppScreen.more:
        return "/more";
      case AppScreen.myAlarms:
        return "/my-alarms";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case AppScreen.onboarding:
        return "START";
      case AppScreen.termsAndConditions:
        return "TERMS AND CONDITIONS";
      case AppScreen.loading:
        return "LOADING";
      case AppScreen.login:
        return "LOGIN";
      case AppScreen.signup:
        return "SIGNUP";
      case AppScreen.signupPasswordStep:
        return "SIGNUP PASSWORD STEP";
      case AppScreen.signupSelectProofTypeStep:
        return "SIGNUP SELECT PROOF TYPE STEP";
      case AppScreen.signupProofInfoStep:
        return "SIGNUP PROOF INFO STEP";
      case AppScreen.signupNationalInfoStep:
        return "SIGNUP NATIONAL INFO STEP";
      case AppScreen.forgotPassword:
        return "FORGOT PASSWORD";
      case AppScreen.forgotPasswordVerifyOtpStep:
        return "FORGOT PASSWORD VERIFY OTP STEP";
      case AppScreen.forgotPasswordResetStep:
        return "FORGOT PASSWORD RESET STEP";
      case AppScreen.myPayments:
        return "MY PAYMENTS";
      case AppScreen.settings:
        return "SETTINGS";
      case AppScreen.changePassword:
        return "SETTINGS CHANGE PASSWORD";
      case AppScreen.profile:
        return "PROFILE";
      case AppScreen.addMyVehicle:
        return "ADD MY VEHICLE";
      case AppScreen.addMyVehicleDetailsStepOne:
        return "ADD MY VEHICLE DETAILS STEP ONE";
      case AppScreen.addMyVehicleDetailsStepTwo:
        return "ADD MY VEHICLE DETAILS STEP TWO";
      case AppScreen.addMyVehiclePictureStep:
        return "ADD MY VEHICLE PICTURE STEP";
      case AppScreen.payment:
        return "PAYMENT";
      case AppScreen.paymentVerifyOtpStep:
        return "PAYMENT VERIFY OTP STEP";
      case AppScreen.issueInsurance:
        return "ISSUE INSURANCE";
      case AppScreen.issueInstallmentDetails:
        return "ISSUE INSTALLMENT DETAILS";
      case AppScreen.reminder:
        return "REMINDER";
      case AppScreen.reminderInsuranceInfoStep:
        return "REMINDER INSURANCE INFO STEP";
      case AppScreen.comparePrices:
        return "COMPARE PRICES";
      case AppScreen.companies:
        return "COMPANIES";
      case AppScreen.companyDetails:
        return "COMPANY DETAILS";
      case AppScreen.companyBranches:
        return "COMPANY BRANCHES";
      case AppScreen.notifications:
        return "NOTIFICATIONS";
      case AppScreen.carsInsurance:
        return "CARS INSURANCE";
      case AppScreen.noConnection:
        return "NO CONNECTION";
      case AppScreen.home:
        return "HOME";
      case AppScreen.myVehicles:
        return "MY VEHICLES";
      case AppScreen.myHiddenVehicles:
        return "MY HIDDEN VEHICLES";
      case AppScreen.myInsurances:
        return "MY INSURANCES";
      case AppScreen.insuranceDocument:
        return "INSURANCE DOCUMENT";
      case AppScreen.more:
        return "MORE";
      case AppScreen.myAlarms:
        return "MY ALARMS";
    }
  }

  String get toSubPath {
    switch (this) {
      case AppScreen.changePassword:
        return 'change-password';
      case AppScreen.companyDetails:
        return 'company:company_id';
      case AppScreen.companyBranches:
        return 'branches';
      default:
        return '';
    }
  }
}
