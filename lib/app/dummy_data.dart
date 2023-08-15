import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/insurance_types_enum.dart';
import 'package:insurance_app/domain/entities/insurance.dart';
import 'package:insurance_app/domain/entities/payment_method.dart';

String fistName = "مرام";
String middleName = "محمد";
String lastName = "العمامي";
const id = "01015323";
String email = "user@email.com";
String phone = "0920000000";
String birthDate = "18-1-1998";
bool isLibyan = true;

const List<Map<String, String>> cities = [
  {'id': '1', 'value': 'طرابلس'},
  {'id': '2', 'value': 'بنغازي'},
  {'id': '3', 'value': 'مصراتة'},
  {'id': '4', 'value': 'الزاوية'},
  {'id': '5', 'value': 'زوارة'},
  {'id': '6', 'value': 'سبها'},
  {'id': '7', 'value': 'صبراتة'},
];

const List<Map<String, String>> insuranceCompanies = [
  {'id': '1', 'value': 'شركة البركة للتأمين'},
  {'id': '2', 'value': 'شركة تيبستي للتأمين'},
  {'id': '3', 'value': 'الشركة العالمية للتأمين'},
];

const List<Map<String, String>> alarmTypes = [
  {'id': '1', 'value': 'الفحص الفني'},
  {'id': '2', 'value': 'التأمين الاجباري'},
];

const List<Map<String, String>> remindMeOptions = [
  {'id': '1', 'value': 'قبل يوم'},
  {'id': '2', 'value': 'قبل 3 ايام'},
  {'id': '3', 'value': 'قبل اسبوع'},
  {'id': '4', 'value': 'قبل اسبوعين'},
  {'id': '5', 'value': 'قبل شهر'},
];

const List<Map<String, String>> typesOfCarInsurance = [
  {'id': '1', 'value': 'وثيقة تأمين سيارة إجباري'},
  {'id': '2', 'value': 'وثيقة تأمين سيارة شامل'},
  {'id': '3', 'value': 'وثيقة تأمين المنافع الإضافية'},
];

const List<Map<String, String>> horsePower = [
  {'id': '1', 'value': '8'},
  {'id': '2', 'value': '10'},
  {'id': '3', 'value': '12'},
  {'id': '4', 'value': '14'},
  {'id': '5', 'value': '16'},
];

const List<Map<String, String>> seatsNumber = [
  {'id': '1', 'value': '2'},
  {'id': '2', 'value': '4'},
  {'id': '3', 'value': '5'},
  {'id': '4', 'value': '6'},
  {'id': '5', 'value': '7'},
  {'id': '6', 'value': '8'},
];

const List<Map<String, String>> seatsNumberWithoutTheDriver = [
  {'id': '1', 'value': '1'},
  {'id': '2', 'value': '3'},
  {'id': '3', 'value': '4'},
  {'id': '4', 'value': '5'},
  {'id': '5', 'value': '6'},
  {'id': '6', 'value': '7'},
];

const List<Map<String, String>> colors = [
  {'id': '1', 'value': 'أحمر'},
  {'id': '2', 'value': 'أزرق'},
  {'id': '3', 'value': 'أخضر'},
  {'id': '4', 'value': 'أصفر'},
  {'id': '5', 'value': 'أسود'},
  {'id': '6', 'value': 'أبيض'},
];

const List<Map<String, String>> test = [
  {'id': '1', 'value': 'تجربة 1'},
  {'id': '2', 'value': 'تجربة 2'},
  {'id': '3', 'value': 'تجربة 3'},
  {'id': '4', 'value': 'تجربة 4'},
];

const List<Map<String, String>> carBrands = [
  {'id': '1', 'value': 'فولسفاغن', 'imgPath': ImageAssets.volkswagen},
  {'id': '2', 'value': 'كيا', 'imgPath': ImageAssets.kia},
  {'id': '3', 'value': 'مرسيدس', 'imgPath': ImageAssets.mercedes},
  {'id': '4', 'value': 'جيب', 'imgPath': ImageAssets.jeep},
  {'id': '5', 'value': 'هيونداي', 'imgPath': ImageAssets.hyundai},
  {'id': '6', 'value': 'ليكسز', 'imgPath': ImageAssets.lexus},
  {'id': '7', 'value': 'بورش', 'imgPath': ImageAssets.porsche},
  {'id': '8', 'value': 'تويوتا', 'imgPath': ImageAssets.toyota},
  {'id': '9', 'value': 'اودي', 'imgPath': ImageAssets.audi},
];

const List<Map<String, String>> myVehicles = [
  {'id': '1', 'value': 'كيا أوبتما 2007', 'imgPath': ImageAssets.kia},
  {'id': '2', 'value': 'هيونداي اكسنت 2012', 'imgPath': ImageAssets.hyundai},
];

const List<Map<String, String>> vehicleYears = [
  {'id': '1', 'value': '2000'},
  {'id': '2', 'value': '2001'},
  {'id': '3', 'value': '2002'},
  {'id': '4', 'value': '2003'},
  {'id': '5', 'value': '2004'},
  {'id': '6', 'value': '2005'},
  {'id': '7', 'value': '2006'},
  {'id': '8', 'value': '2007'},
  {'id': '9', 'value': '2008'},
  {'id': '10', 'value': '2009'},
  {'id': '11', 'value': '2010'},
  {'id': '12', 'value': '2011'},
  {'id': '13', 'value': '2012'},
  {'id': '14', 'value': '2013'},
  {'id': '15', 'value': '2014'},
  {'id': '16', 'value': '2015'},
  {'id': '17', 'value': '2016'},
  {'id': '18', 'value': '2017'},
  {'id': '19', 'value': '2018'},
  {'id': '20', 'value': '2019'},
  {'id': '21', 'value': '2020'},
  {'id': '22', 'value': '2021'},
  {'id': '23', 'value': '2022'},
  {'id': '24', 'value': '2023'},
];

const List<Map<String, String>> theNumberOfMonthlyInstallments = [
  {'id': '1', 'value': 'شهرين'},
  {'id': '2', 'value': '3 أشهر'},
  {'id': '3', 'value': '4 أشهر'},
  {'id': '4', 'value': '5 أشهر'},
  {'id': '5', 'value': '6 أشهر'},
  {'id': '6', 'value': '7 أشهر'},
  {'id': '7', 'value': '8 أشهر'},
  {'id': '8', 'value': '9 أشهر'},
  {'id': '9', 'value': '10 أشهر'},
  {'id': '10', 'value': '11 أشهر'},
  {'id': '11', 'value': 'عام'},
];

const List<PaymentMethod> paymentMethods = [
  PaymentMethod(id: '1', name: 'موبي كاش', imagePath: ImageAssets.mobicash),
  PaymentMethod(id: '2', name: 'ناب 4 باي', imagePath: ImageAssets.nab4pay),
  PaymentMethod(id: '3', name: 'سداد', imagePath: ImageAssets.sadad),
  PaymentMethod(id: '4', name: 'تداول', imagePath: ImageAssets.tadawul),
  PaymentMethod(id: '5', name: 'معاملات', imagePath: ImageAssets.moamalat),
];

const List<Map<String, String>> vehicleCountry = [
  {'id': '1', 'value': 'ليبيا', 'svgPath': SvgAssets.libya},
  {'id': '2', 'value': 'المانيا', 'svgPath': SvgAssets.germany},
];
// const List<Map<String, String>> paymentMethods = [
//   {'id': '1', 'value': 'موبي كاش', 'imgPath': ImageAssets.mobicash},
//   {'id': '2', 'value': 'ناب 4 باي', 'imgPath': ImageAssets.nab4pay},
//   {'id': '3', 'value': 'سداد', 'imgPath': ImageAssets.sadad},
//   {'id': '4', 'value': 'تداول', 'imgPath': ImageAssets.tadawul},
//   {'id': '5', 'value': 'معاملات', 'imgPath': ImageAssets.moamalat},
// ];

const underProcessingInsurances = <Insurance>[];
const issuedInsurances = <Insurance>[
  Insurance(
    id: '1',
    insuranceTypeId: '1',
    carBrandId: '5',
    insuranceCompanyId: '1',
    referenceNumber: '112233',
    issuanceDate: '1-1-2023',
    insuredName: 'حسين الشريف',
    insuranceType: 'وثيقة تأمين سيارة إجباري',
    insuranceCompany: 'شركة تيبستي للتأمين',
    carBrand: 'هيونداي',
    carBrandImgPath: ImageAssets.hyundai,
    insuranceStatus: InsuranceStatus.issued,
  ),
];
const notPaidInsurances = <Insurance>[
  Insurance(
    id: '2',
    insuranceTypeId: '1',
    carBrandId: '2',
    insuranceCompanyId: '1',
    referenceNumber: '008096',
    issuanceDate: '1-11-2022',
    insuredName: 'مرام عبدالباسط القدري',
    insuranceType: 'وثيقة تأمين سيارة إجباري',
    insuranceCompany: 'شركة تيبستي للتأمين',
    carBrand: 'كيا',
    carBrandImgPath: ImageAssets.kia,
    insuranceStatus: InsuranceStatus.notPaid,
  ),
];
const expiredInsurances = <Insurance>[];
