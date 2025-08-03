import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
 
class AppTypography {
  static const headline1 = TextStyle(
    fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary,
  );
  static const subtitle = TextStyle(
    fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textPrimary,
  );
  static const body = TextStyle(
    fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary,
  );
  static const caption = TextStyle(
    fontSize: 14, color: Colors.grey,
  );

  
}