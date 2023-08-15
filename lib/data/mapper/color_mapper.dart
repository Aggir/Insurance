import 'package:flutter/material.dart';
import 'package:insurance_app/app/constants.dart';
import 'package:insurance_app/app/functions.dart';
import 'package:insurance_app/data/models/color_model.dart';
import 'package:insurance_app/domain/entities/color.dart';

extension ColorModelExtension on ColorModel? {
  ColorEntity toDomain() => this == null
      ? const ColorEntity(
          id: Constants.zero, name: Constants.empty, color: Colors.transparent)
      : ColorEntity(
          id: this!.id,
          name: this!.name,
          color: colorFromHexString(this!.hex),
        );
}
