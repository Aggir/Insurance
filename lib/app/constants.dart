import 'package:insurance_app/app/functions.dart';
import 'package:insurance_app/domain/entities/remind_me_in.dart';

class Constants {
  static const String appName = "Insurance";

  static const String empty = "";
  static const int zero = 0;
  static const double dZero = 0.0;

  static const List<String> allowedDocumentExtensions = [
    'jpg',
    'pdf',
    'png',
    'jpeg',
    'webp',
  ];
  static const List<String> allowedPictureExtensions = [
    'jpg',
    'png',
    'jpeg',
    'webp',
  ];

  static const List<RemindMeInEntity> remindMeOptions = [
    RemindMeInEntity(id: 1, days: 1, name: 'قبل يوم'),
    RemindMeInEntity(id: 2, days: 3, name: 'قبل 3 أيام'),
    RemindMeInEntity(id: 3, days: 7, name: 'قبل اسبوع'),
    RemindMeInEntity(id: 4, days: 14, name: 'قبل اسبوعين'),
  ];

  static List<int> vehicleYears = generateYearsList();

  static const List<Map<String, String>> insurancePeriod = [
    {'period': '1', 'name': 'سنة'},
    {'period': '2', 'name': 'سنتين'},
    {'period': '3', 'name': '3 سنين'},
  ];
}
