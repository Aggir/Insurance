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

//  [
//   2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,
//   {'id': '1', 'value': '2000'},
//   {'id': '2', 'value': '2001'},
//   {'id': '3', 'value': '2002'},
//   {'id': '4', 'value': '2003'},
//   {'id': '5', 'value': '2004'},
//   {'id': '6', 'value': '2005'},
//   {'id': '7', 'value': '2006'},
//   {'id': '8', 'value': '2007'},
//   {'id': '9', 'value': '2008'},
//   {'id': '10', 'value': '2009'},
//   {'id': '11', 'value': '2010'},
//   {'id': '12', 'value': '2011'},
//   {'id': '13', 'value': '2012'},
//   {'id': '14', 'value': '2013'},
//   {'id': '15', 'value': '2014'},
//   {'id': '16', 'value': '2015'},
//   {'id': '17', 'value': '2016'},
//   {'id': '18', 'value': '2017'},
//   {'id': '19', 'value': '2018'},
//   {'id': '20', 'value': '2019'},
//   {'id': '21', 'value': '2020'},
//   {'id': '22', 'value': '2021'},
//   {'id': '23', 'value': '2022'},
//   {'id': '24', 'value': '2023'},
// ];
}
