import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nano_tech_cosmetic/core/constants/app_colors.dart';

abstract class AppThemes {
  static ThemeData themeEnglish = ThemeData(
    primaryColor: AppColors.materialPrimary,
    scaffoldBackgroundColor: AppColors.white,
    splashColor: AppColors.materialPrimary.shade200,
    canvasColor: AppColors.materialPrimary.shade50,
    iconTheme: const IconThemeData(
      color: AppColors.gray,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.materialPrimary,
      backgroundColor: AppColors.materialPrimary.shade50,
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.sniglet(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
        color: AppColors.materialPrimary.shade800,
      ),
      headlineMedium: GoogleFonts.sniglet(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        color: AppColors.materialPrimary.shade800,
      ),
      headlineSmall: GoogleFonts.calistoga(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
        color: AppColors.white,
      ),
      titleLarge: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
        color: AppColors.gray,
      ),
      // AppBar
      titleMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
        color: AppColors.gray,
      ),
      // TextField
      titleSmall: GoogleFonts.calistoga(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        color: AppColors.materialPrimary.shade700,
      ),
      bodyLarge: GoogleFonts.acme(
        fontSize: 18,
        color: AppColors.gray,
        letterSpacing: 1,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 16,
        color: AppColors.gray,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w700,
      ),
      // Text, NavBarItems
      bodySmall: GoogleFonts.roboto(
        fontSize: 16,
        color: AppColors.gray,
        fontWeight: FontWeight.w800,
      ),
      labelLarge: GoogleFonts.acme(
        fontSize: 18,
        color: AppColors.materialPrimary.shade600,
        fontWeight: FontWeight.w800,
      ),
      // Button
      labelMedium: GoogleFonts.acme(
        fontSize: 16,
        color: AppColors.materialPrimary.shade600,
        fontWeight: FontWeight.w900,
      ),
      labelSmall: GoogleFonts.acme(
        fontSize: 14,
        color: AppColors.materialPrimary.shade600,
        fontWeight: FontWeight.w800,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.materialPrimary.shade50,
      iconTheme: IconThemeData(
        color: AppColors.materialPrimary.shade800,
        size: 25,
      ),
      elevation: 1,
      scrolledUnderElevation: 0,
      titleSpacing: 1,
    ),
    indicatorColor: AppColors.materialPrimary.shade600,
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.materialPrimary.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: GoogleFonts.oxygen(
        fontSize: 18,
        color: AppColors.black,
        fontWeight: FontWeight.w800,
      ),
    ),
    timePickerTheme: const TimePickerThemeData(),
  );
  static ThemeData themeArabic = ThemeData(
    primaryColor: AppColors.materialPrimary,
    scaffoldBackgroundColor: AppColors.white,
    splashColor: AppColors.materialPrimary.shade200,
    canvasColor: AppColors.materialPrimary.shade50,
    iconTheme: const IconThemeData(
      color: AppColors.gray,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColors.materialPrimary,
      backgroundColor: AppColors.materialPrimary.shade50,
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.sniglet(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
        color: AppColors.materialPrimary.shade800,
      ),
      headlineMedium: GoogleFonts.sniglet(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        color: AppColors.materialPrimary.shade800,
      ),
      headlineSmall: GoogleFonts.calistoga(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
        color: AppColors.white,
      ),
      titleLarge: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
        color: AppColors.gray,
      ),
      // AppBar
      titleMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        letterSpacing: 1,
        color: AppColors.gray,
      ),
      // TextField
      titleSmall: GoogleFonts.calistoga(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        color: AppColors.materialPrimary.shade700,
      ),
      bodyLarge: GoogleFonts.acme(
        fontSize: 18,
        color: AppColors.gray,
        letterSpacing: 1,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 16,
        color: AppColors.gray,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w700,
      ),
      // Text, NavBarItems
      bodySmall: GoogleFonts.roboto(
        fontSize: 16,
        color: AppColors.gray,
        fontWeight: FontWeight.w800,
      ),
      labelLarge: GoogleFonts.acme(
        fontSize: 18,
        color: AppColors.materialPrimary.shade600,
        fontWeight: FontWeight.w800,
      ),
      // Button
      labelMedium: GoogleFonts.acme(
        fontSize: 16,
        color: AppColors.materialPrimary.shade600,
        fontWeight: FontWeight.w900,
      ),
      labelSmall: GoogleFonts.acme(
        fontSize: 14,
        color: AppColors.materialPrimary.shade600,
        fontWeight: FontWeight.w800,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.materialPrimary.shade50,
      iconTheme: IconThemeData(
        color: AppColors.materialPrimary.shade800,
        size: 25,
      ),
      elevation: 1,
      scrolledUnderElevation: 0,
      titleSpacing: 1,
    ),
    indicatorColor: AppColors.materialPrimary.shade600,
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.materialPrimary.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: GoogleFonts.oxygen(
        fontSize: 18,
        color: AppColors.black,
        fontWeight: FontWeight.w800,
      ),
    ),
    timePickerTheme: const TimePickerThemeData(),
  );
}
