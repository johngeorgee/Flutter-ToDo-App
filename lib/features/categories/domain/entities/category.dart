// ignore_for_file: non_const_argument_for_const_parameter

import 'package:flutter/material.dart';

class Category {
  Category({
    required this.id,
    required this.name,
    required this.colorValue,
    this.iconCodePoint,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final int colorValue;
  final int? iconCodePoint;
  final DateTime createdAt;
  final DateTime updatedAt;

  Color get color => Color(colorValue);

  IconData? get icon => iconCodePoint != null
      ? IconData(iconCodePoint!, fontFamily: 'MaterialIcons')
      : null;

  Category copyWith({
    String? id,
    String? name,
    int? colorValue,
    int? Function()? iconCodePoint,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      iconCodePoint:
          iconCodePoint != null ? iconCodePoint() : this.iconCodePoint,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
