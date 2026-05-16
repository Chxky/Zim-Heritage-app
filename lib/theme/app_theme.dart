import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Heritage Futurism Color Palette
  static const Color background = Color(0xFF0B1A10);
  static const Color surfaceDark = Color(0xFF0F2416);
  static const Color surfaceMid = Color(0xFF152E1C);
  static const Color surfaceLight = Color(0xFF1C3A25);

  static const Color primaryGreen = Color(0xFF006B3F);
  static const Color greenBright = Color(0xFF00A85A);
  static const Color greenGlow = Color(0xFF00E676);
  static const Color gold = Color(0xFFFFC72C);
  static const Color goldBright = Color(0xFFFFD54F);
  static const Color goldLight = Color(0xFFFFE082);
  static const Color red = Color(0xFFCC0000);
  static const Color redBright = Color(0xFFFF1744);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Glass / Transparency helpers
  static const Color white90 = Color(0xE6FFFFFF);
  static const Color white85 = Color(0xD9FFFFFF);
  static const Color white80 = Color(0xCCFFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color white50 = Color(0x80FFFFFF);
  static const Color white30 = Color(0x4DFFFFFF);
  static const Color white20 = Color(0x33FFFFFF);
  static const Color white15 = Color(0x26FFFFFF);
  static const Color white10 = Color(0x1AFFFFFF);

  static const Color darkGreen = Color(0xFF004D2E);
  static const Color lightGreen = Color(0xFFE8F5E9);
  static const Color cream = Color(0xFFFFF8E1);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyMedium = Color(0xFF9E9E9E);
  static const Color greyDark = Color(0xFF616161);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [darkGreen, Color(0xFF008856)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [gold, Color(0xFFFFD54F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient splashGradient = LinearGradient(
    colors: [Color(0xFF06120A), Color(0xFF0B1A10), Color(0xFF0F2416)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient flagBarGradient = LinearGradient(
    colors: [
      Color(0xFF006B3F),
      Color(0xFFFFC72C),
      Color(0xFF000000),
      Color(0xFFCC0000),
      Color(0xFFFFC72C),
      Color(0xFF006B3F),
    ],
    stops: [0.0, 0.25, 0.45, 0.55, 0.75, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0x1AFFFFFF), Color(0x08FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const List<BoxShadow> cardGlow = [
    BoxShadow(
      color: Color(0x1A00E676),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> goldGlow = [
    BoxShadow(
      color: Color(0x1AFFC72C),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> softShadow = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.dark(
        primary: primaryGreen,
        secondary: gold,
        error: red,
        surface: surfaceDark,
        onPrimary: white,
        onSecondary: black,
        onSurface: white,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.dark().textTheme.copyWith(
          displayLarge: const TextStyle(color: white, fontWeight: FontWeight.bold),
          displayMedium: const TextStyle(color: white, fontWeight: FontWeight.bold),
          displaySmall: const TextStyle(color: white, fontWeight: FontWeight.bold),
          headlineLarge: const TextStyle(color: white, fontWeight: FontWeight.bold),
          headlineMedium: const TextStyle(color: white, fontWeight: FontWeight.w600),
          headlineSmall: const TextStyle(color: white, fontWeight: FontWeight.w600),
          titleLarge: const TextStyle(color: white, fontWeight: FontWeight.w600),
          titleMedium: const TextStyle(color: white, fontWeight: FontWeight.w500),
          titleSmall: const TextStyle(color: white70, fontWeight: FontWeight.w500),
          bodyLarge: const TextStyle(color: white80),
          bodyMedium: const TextStyle(color: white70),
          bodySmall: const TextStyle(color: white60),
          labelLarge: const TextStyle(color: white80, fontWeight: FontWeight.w600),
          labelMedium: const TextStyle(color: white70),
          labelSmall: const TextStyle(color: white60),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: white,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surfaceMid,
        shadowColor: greenGlow.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: white10),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: white,
          elevation: 4,
          shadowColor: greenGlow.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: greenBright, width: 1),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: gold,
          side: const BorderSide(color: gold),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceMid,
        hintStyle: TextStyle(color: white30),
        labelStyle: TextStyle(color: white60),
        prefixIconColor: white50,
        suffixIconColor: white50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: white20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: white20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: gold, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: redBright),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceDark,
        selectedItemColor: gold,
        unselectedItemColor: white50,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 10),
      ),
      dividerTheme: DividerThemeData(
        color: white10,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceMid,
        contentTextStyle: const TextStyle(color: white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: white20),
        ),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: white,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: gold,
        linearTrackColor: Color(0x33FFFFFF),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceMid,
        labelStyle: const TextStyle(color: white80, fontSize: 12),
        side: BorderSide(color: white20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryGreen,
        foregroundColor: white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: white20),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        iconColor: white70,
        collapsedIconColor: white50,
        textColor: white,
        collapsedTextColor: white80,
        shape: Border(),
        collapsedShape: Border(),
      ),
    );
  }
}
