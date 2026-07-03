import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const seed = Color(0xFF6750A4);

  // Priority
  static const priorityHigh = Color(0xFFE53935);
  static const priorityMedium = Color(0xFFFB8C00);
  static const priorityLow = Color(0xFF43A047);
  static const priorityNone = Color(0xFF9E9E9E);

  // Category
  static const categoryWork = Color(0xFF5C6BC0);
  static const categoryPersonal = Color(0xFF26A69A);
  static const categoryShopping = Color(0xFFEC407A);
  static const categoryHealth = Color(0xFF66BB6A);
  static const categoryOther = Color(0xFF78909C);

  // Semantic
  static const success = Color(0xFF2E7D32);
  static const warning = Color(0xFFF57C00);
  static const error = Color(0xFFC62828);

  // Surfaces (light)
  static const surfaceLight = Color(0xFFF8F9FA);
  static const cardLight = Color(0xFFFFFFFF);

  // Surfaces (dark)
  static const surfaceDark = Color(0xFF121212);
  static const cardDark = Color(0xFF1E1E1E);
}
