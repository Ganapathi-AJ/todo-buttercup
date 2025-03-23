import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Todo - Buttercup';
  static const String appVersion = '1.0.0';
  
  // Category colors
  static const List<Map<String, dynamic>> predefinedCategoryColors = [
    {'name': 'Lavender', 'color': 0xFF8E7CC3},
    {'name': 'Ocean', 'color': 0xFF64B5F6},
    {'name': 'Mint', 'color': 0xFF81C784},
    {'name': 'Coral', 'color': 0xFFFF8A65},
    {'name': 'Berry', 'color': 0xFFE57373},
    {'name': 'Sky', 'color': 0xFF4FC3F7},
    {'name': 'Amber', 'color': 0xFFFFB74D},
    {'name': 'Lime', 'color': 0xFFAED581},
    {'name': 'Pink', 'color': 0xFFF48FB1},
    {'name': 'Teal', 'color': 0xFF4DB6AC},
  ];
  
  // Priority Colors
  static const Color lowPriorityColor = Color(0xFF8BC34A);
  static const Color mediumPriorityColor = Color(0xFFFFA726);
  static const Color highPriorityColor = Color(0xFFEF5350);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6A7FDB), Color(0xFF8F60DE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF8F60DE), Color(0xFFB160DE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Animation durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 350);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  
  // Max lengths
  static const int titleMaxLength = 100;
  static const int descriptionMaxLength = 1000;
  static const int categoryNameMaxLength = 30;
  
  // Default values
  static const List<String> defaultCategories = [
    'Personal',
    'Work',
    'Shopping',
    'Health',
    'Education',
  ];
} 