import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ColorEntity extends Equatable {
  final int id;
  final Color color;
  final String name;

  const ColorEntity({
    required this.id,
    required this.color,
    required this.name,
  });

  @override
  List<Object> get props => [
        id,
        color,
        name,
      ];
}
