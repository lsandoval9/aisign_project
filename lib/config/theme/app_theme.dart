import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  final bool _isDarkMode;
  final Color primaryColor = const Color(0xFF703FC7);
  final Color secondaryColor = const Color(0xff0DD97B);
  final Color tertiaryColor = const Color(0xff0db7d9);

  final Color darkPrimaryColor = const Color(0xFF5F31B6);
  final Color darkSecondaryColor = const Color(0xff0cc26e);
  final Color darkTertiaryColor = const Color(0xff0baccc);

  final Color lightPrimaryColor = const Color(0xffc4b0ff);

  final Color lightDivisionColor = const Color(0xffe0e0e0);
  final Color darkDivisionColor = const Color(0xff2a3948);

  // text

  final Color lightTextColor = const Color(0xe61e2732);
  final Color darkTextColor = const Color(0xfafafafa);

  final deviceIsDarkMode = false;

  AppTheme({
    bool? isDarkMode,
  }) : _isDarkMode = isDarkMode ?? false;

  AppTheme copyWith({bool? isDarkMode}) {
    return AppTheme(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme(
      primary: isDarkMode ? darkPrimaryColor : primaryColor,
      secondary: isDarkMode ? darkSecondaryColor : secondaryColor,
      tertiary: isDarkMode ? darkTertiaryColor : tertiaryColor,
      surface: isDarkMode ? const Color(0xFF1e2732): const Color(0xfff2f4f6),
      surfaceVariant: isDarkMode ? const Color(0xFF273340): const Color(0xffdcdcdc),
      background: isDarkMode ? const Color(0xFF15202b): const Color(0xfffafafa),
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      onSurface: isDarkMode ? Colors.grey[300]!
          : Colors.grey[800]!,
      onBackground: isDarkMode ? Colors.grey[400]! : Colors.grey[900]!,
      onError: Colors.white,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      onSurfaceVariant: isDarkMode ? Colors.grey[400]! : Colors.grey[800]!,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
          fontSize: 57,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5
      ),
      displayMedium: GoogleFonts.roboto(
          fontSize: 45,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5
      ),
      displaySmall: GoogleFonts.roboto(
          fontSize: 48,
          fontWeight: FontWeight.w400
      ),
      headlineMedium: GoogleFonts.roboto(
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25
      ),
      headlineSmall: GoogleFonts.roboto(
          fontSize: 24,
          fontWeight: FontWeight.w400
      ),
      titleLarge: GoogleFonts.roboto(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15
      ),
      titleMedium: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15
      ),
      titleSmall: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.1
      ),
      bodyLarge: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5
      ),
      bodyMedium: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25
      ),
      labelLarge: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25
      ),
      bodySmall: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4
      ),
      labelSmall: GoogleFonts.roboto(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 1
      ),
      labelMedium: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 1
      ),
    ),
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    useMaterial3: true,
    splashColor: isDarkMode ? primaryColor : lightPrimaryColor,
    drawerTheme: const DrawerThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
      thickness: 1,
      space: 0,
      color: isDarkMode ? darkDivisionColor : lightDivisionColor,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      buttonColor: isDarkMode ? darkPrimaryColor : primaryColor,
      disabledColor: isDarkMode ? darkDivisionColor : lightDivisionColor,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 1,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
    ),
  );

  bool get isDarkMode => _isDarkMode;

  Color get getPrimaryColor => primaryColor;

  Color get getSecondaryColor => secondaryColor;
}