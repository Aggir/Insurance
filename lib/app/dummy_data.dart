import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/app/enums/insurance_types_enum.dart';
import 'package:insurance_app/domain/entities/insurance.dart';
import 'package:insurance_app/domain/entities/payment_method.dart';

String fistName = "مرام";
String middleName = "محمد";
String lastName = "العمامي";
const id = "a989bc";
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
  {'id': '1', 'value': 'وثيقة تأمين سيارة إجباري'},
  {'id': '2', 'value': 'وثيقة تأمين سيارة شامل'},
  {'id': '3', 'value': 'وثيقة تأمين المنافع الإضافية'},
];

const List<Map<String, String>> typesOfCarInsurance = [
  {'id': '1', 'value': 'وثيقة تأمين سيارة إجباري'},
  {'id': '2', 'value': 'وثيقة تأمين سيارة شامل'},
  {'id': '3', 'value': 'وثيقة تأمين المنافع الإضافية'},
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

const List<PaymentMethod> paymentMethods = [
  PaymentMethod(id: '1', name: 'موبي كاش', imagePath: ImageAssets.mobicash),
  PaymentMethod(id: '2', name: 'ناب 4 باي', imagePath: ImageAssets.nab4pay),
  PaymentMethod(id: '3', name: 'سداد', imagePath: ImageAssets.sadad),
  PaymentMethod(id: '4', name: 'تداول', imagePath: ImageAssets.tadawul),
  PaymentMethod(id: '5', name: 'معاملات', imagePath: ImageAssets.moamalat),
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
