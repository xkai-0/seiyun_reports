import 'package:flutter/material.dart';

class AppTheme {
  // الألوان الأساسية للتطبيق
  static const Color primaryGreen = Color(0xFF2E7D32); // الأخضر الداكن
  static const Color accentGreen = Color(0xFF2ECC71); // الأخضر الفاتح
  static const Color darkGreen = Color(0xFF1B5E20); // الأخضر الغامق جداً
  static const Color primaryBrown = Color(0xFF5D4037); // البني الأساسي
  static const Color backgroundColor = Color(0xFFF5F7F9);
  static const Color errorColor = Color(0xFFD32F2F); // لون الخطأ (أحمر)
  static const Color errorContainer = Color(
    0xFFFFEBEE,
  ); // خلفية الخطأ (أحمر فاتح)

  // تدرجات الألوان لشاشة الملف الشخصي
  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const LinearGradient rewardsGradient = LinearGradient(
    colors: [Color(0xFFD48100), Color(0xFFE6A700)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color creamColor = Color(0xFFFDF5E6);

  // aliases for backward compatibility or general use
  static const Color primaryColor = primaryGreen;
  static const Color secondaryColor = primaryBrown;

  static final ColorScheme _colorScheme = ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
    secondary: secondaryColor,
    error: errorColor,
    errorContainer: errorContainer,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
      scaffoldBackgroundColor: backgroundColor,

      // تنسيق الأزرار الافتراضي
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // تنسيق AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),

      // تنسيق الـ Text
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
