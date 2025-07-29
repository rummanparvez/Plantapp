import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Main colors
  static const Color primaryColor = Color(0xFF14B8A6); // Teal accent
  static const Color secondaryColor = Color(0xFF27AE60); // Green
  static const Color accentColor = Color(0xFF7CFFCB); // Light teal
  
  // UI colors
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color cardColor = Color(0xFF1E1E1E);
  static const Color surfaceColor = Color(0xFF262626);
  
  // Status colors
  static const Color successColor = Color(0xFF4ADE80);
  static const Color warningColor = Color(0xFFFCD34D);
  static const Color errorColor = Color(0xFFF87171);
  
  // Text colors
  static const Color primaryTextColor = Color(0xFFFFFFFF);
  static const Color secondaryTextColor = Color(0xFFB3B3B3);
  static const Color disabledTextColor = Color(0xFF666666);

  // Button colors
  static const Color buttonColor = primaryColor;
  static const Color buttonTextColor = Color(0xFF000000);

  // Elevations
  static const double cardElevation = 4.0;
  static const double buttonElevation = 2.0;

  // Border radius
  static const double borderRadius = 16.0;
  static BorderRadius defaultBorderRadius = BorderRadius.circular(borderRadius);
  static BorderRadius smallBorderRadius = BorderRadius.circular(8.0);

  // Theme data
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkBackgroundColor,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      error: errorColor,
    ),
    cardTheme: CardThemeData(
      color: cardColor,
      elevation: cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: defaultBorderRadius,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: buttonTextColor,
        elevation: buttonElevation,
        shape: RoundedRectangleBorder(
          borderRadius: smallBorderRadius,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: smallBorderRadius,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: smallBorderRadius,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme.copyWith(
        displayLarge: const TextStyle(color: primaryTextColor),
        displayMedium: const TextStyle(color: primaryTextColor),
        displaySmall: const TextStyle(color: primaryTextColor),
        headlineLarge: const TextStyle(color: primaryTextColor),
        headlineMedium: const TextStyle(color: primaryTextColor),
        headlineSmall: const TextStyle(color: primaryTextColor),
        titleLarge: const TextStyle(color: primaryTextColor),
        titleMedium: const TextStyle(color: primaryTextColor),
        titleSmall: const TextStyle(color: primaryTextColor),
        bodyLarge: const TextStyle(color: primaryTextColor, height: 1.5),
        bodyMedium: const TextStyle(color: primaryTextColor, height: 1.5),
        bodySmall: const TextStyle(color: secondaryTextColor, height: 1.5),
        labelLarge: const TextStyle(color: primaryTextColor),
        labelMedium: const TextStyle(color: primaryTextColor),
        labelSmall: const TextStyle(color: secondaryTextColor),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      border: OutlineInputBorder(
        borderRadius: smallBorderRadius,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: smallBorderRadius,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: smallBorderRadius,
        borderSide: const BorderSide(color: primaryColor, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: smallBorderRadius,
        borderSide: const BorderSide(color: errorColor, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: smallBorderRadius,
        borderSide: const BorderSide(color: errorColor, width: 2.0),
      ),
      labelStyle: const TextStyle(color: secondaryTextColor),
      hintStyle: const TextStyle(color: disabledTextColor),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceColor,
      contentTextStyle: GoogleFonts.poppins(
        color: primaryTextColor,
        fontSize: 14.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: smallBorderRadius,
      ),
      behavior: SnackBarBehavior.floating,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: defaultBorderRadius,
      ),
      titleTextStyle: GoogleFonts.poppins(
        color: primaryTextColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: GoogleFonts.poppins(
        color: primaryTextColor,
        fontSize: 16.0,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: secondaryTextColor,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    ),
  );
}
