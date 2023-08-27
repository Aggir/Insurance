import 'package:insurance_app/app/assets_manager.dart';
import 'package:insurance_app/domain/entities/payment_method.dart';
import 'package:insurance_app/domain/entities/remind_me_in.dart';

const List<RemindMeInEntity> remindMeOptions = [
  RemindMeInEntity(id: 1, days: 1, name: 'قبل يوم'),
  RemindMeInEntity(id: 2, days: 3, name: 'قبل 3 أيام'),
  RemindMeInEntity(id: 3, days: 7, name: 'قبل اسبوع'),
  RemindMeInEntity(id: 4, days: 14, name: 'قبل اسبوعين'),
];

const List<Map<String, String>> typesOfCarInsurance = [
  {'id': '1', 'value': 'وثيقة تأمين سيارة إجباري'},
  {'id': '2', 'value': 'وثيقة تأمين سيارة شامل'},
  {'id': '3', 'value': 'وثيقة تأمين المنافع الإضافية'},
];

const List<int> horsePower = [8, 10, 12, 14, 16, 18, 20];

const List<int> seatsNumberWithoutTheDriver = [1, 3, 4, 5, 6, 7];

const List<Map<String, String>> test = [
  {'id': '1', 'value': 'تجربة 1'},
  {'id': '2', 'value': 'تجربة 2'},
  {'id': '3', 'value': 'تجربة 3'},
  {'id': '4', 'value': 'تجربة 4'},
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
