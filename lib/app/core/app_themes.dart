// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///App Theme
class AppTheme {
  static const Color _lightFocusColor = Colors.black;
  static const Color _darkFocusColor = Colors.green;

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor, lightTextTheme);
  static ThemeData darkThemeData =
      themeData(darkColorScheme, _darkFocusColor, darkTextTheme);

  static FontWeight _getFontWeight(int weight) {
    switch (weight) {
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w400;
      case 500:
        return FontWeight.w500;
      case 600:
        return FontWeight.w600;
      case 700:
        return FontWeight.w700;
      case 800:
        return FontWeight.w800;
      case 900:
        return FontWeight.w900;
    }
    return FontWeight.w400;
  }

  static TextStyle getTextStyle(
    TextStyle textStyle, {
    int fontWeight = 500,
    bool muted = false,
    bool xMuted = false,
    double letterSpacing = 0.0,
    Color? color,
    TextDecoration decoration = TextDecoration.none,
    double? height,
    double wordSpacing = 0,
    double? fontSize,
    double? decorationThickness,
    Color? decorationColor,
    FontStyle? fontStyle,
    String? fontFamily,
  }) {
    double? finalFontSize = fontSize ?? textStyle.fontSize;

    Color? finalColor;
    if (color == null) {
      finalColor = xMuted
          ? textStyle.color!.withAlpha(160)
          : (muted ? textStyle.color!.withAlpha(200) : textStyle.color);
    } else {
      finalColor = xMuted
          ? color.withAlpha(160)
          : (muted ? color.withAlpha(200) : color);
    }
    return GoogleFonts.poppins(
      fontSize: finalFontSize,
      fontWeight: _getFontWeight(fontWeight),
      fontStyle: fontStyle,
      textStyle: TextStyle(fontFamily: fontFamily),
      letterSpacing: letterSpacing,
      color: finalColor,
      decoration: decoration,
      height: height,
      wordSpacing: wordSpacing,
      decorationThickness: decorationThickness,
      decorationColor: decorationColor,
    );
  }

  ///Light Text Theme Colors

  static final TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.jost(
        textStyle: const TextStyle(fontSize: 102, color: Color(0xff4a4c4f))),
    displayMedium: GoogleFonts.oswald(
        textStyle: const TextStyle(fontSize: 64, color: Color(0xff4a4c4f))),
    displaySmall: GoogleFonts.montserrat(
        textStyle: const TextStyle(fontSize: 51, color: Color(0xff4a4c4f))),
    headlineMedium: GoogleFonts.ibmPlexSans(
        textStyle: const TextStyle(fontSize: 36, color: Color(0xff4a4c4f))),
    headlineSmall: GoogleFonts.dmSans(
        textStyle: const TextStyle(fontSize: 25, color: Color(0xff4a4c4f))),
    titleLarge: GoogleFonts.ibmPlexSans(
        textStyle: const TextStyle(fontSize: 18, color: Color(0xff4a4c4f))),
    titleMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 17, color: Color(0xff4a4c4f))),
    titleSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 15, color: Color(0xff4a4c4f))),
    bodyLarge: GoogleFonts.nunitoSans(
        textStyle: const TextStyle(fontSize: 16, color: Color(0xff4a4c4f))),
    bodyMedium: GoogleFonts.dmSerifText(
        textStyle: const TextStyle(fontSize: 14, color: Color(0xff4a4c4f))),
    bodySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 11, color: Color(0xff4a4c4f))),
    labelLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 14, color: Color(0xff4a4c4f))),
    labelMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 11, color: Color(0xff4a4c4f))),
    labelSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 08, color: Color(0xff4a4c4f))),
  );

  ///Dark Text Theme Colors
  static final TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.ibmPlexSans(
        textStyle: const TextStyle(fontSize: 102, color: Colors.white)),
    displayMedium: GoogleFonts.montserrat(
        textStyle: const TextStyle(fontSize: 64, color: Colors.white)),
    displaySmall: GoogleFonts.montserrat(
        textStyle: const TextStyle(fontSize: 51, color: Colors.white)),
    headlineMedium: GoogleFonts.ibmPlexSans(
        textStyle: const TextStyle(fontSize: 36, color: Colors.white)),
    headlineSmall: GoogleFonts.dmSans(
        textStyle: const TextStyle(fontSize: 25, color: Colors.white)),
    titleLarge: GoogleFonts.ibmPlexSans(
        textStyle: const TextStyle(fontSize: 18, color: Colors.white)),
    titleMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 17, color: Colors.white)),
    titleSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 15, color: Colors.white)),
    bodyLarge: GoogleFonts.nunitoSans(
        textStyle: const TextStyle(fontSize: 16, color: Colors.white)),
    bodyMedium: GoogleFonts.dmSerifText(
        textStyle: const TextStyle(fontSize: 14, color: Colors.white)),
    bodySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 11, color: Colors.white)),
    labelLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 15, color: Colors.white)),
    labelMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 11, color: Colors.white)),
    labelSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 08, color: Colors.white)),
  );

  ///ThemeData
  static ThemeData themeData(
      ColorScheme colorScheme, Color focusColor, TextTheme textTheme) {
    return ThemeData(
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
            color: colorScheme.background,
            actionsIconTheme: IconThemeData(color: colorScheme.onBackground),
            iconTheme: IconThemeData(color: colorScheme.onBackground),
            toolbarHeight: AppBar().preferredSize.height,
            elevation: 0),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          },
        ),
        inputDecorationTheme: const InputDecorationTheme(),
        iconTheme: IconThemeData(color: colorScheme.onSecondary),
        canvasColor: colorScheme.background,
        textTheme: textTheme,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        focusColor: focusColor,
        backgroundColor: colorScheme.background,
        bottomAppBarColor: Colors.transparent,
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.transparent),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent));
  }

  static const Gradient gradient = LinearGradient(
    colors: [
      Color(0xff47b1a4),
      Color(0xff7386d2),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
  static const Gradient appBarGradient = LinearGradient(
    colors: [
      Color(0xff47b1a4),
      Color(0xff7386d2),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  static const Gradient iconGradient = LinearGradient(
    colors: [
      Color(0xff47b1a4),
      Color(0xff47b1a4),
      // Color(0xff47b1a4),
      // Color(0xff7386d2),
      Color(0xff7386d2),
      Color(0xff7386d2),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  ///Light Theme Colors
  static ColorScheme lightColorScheme = const ColorScheme(
      primary: Color(0XFF5b298c), //  PRIMARY_COLOR
      onPrimary: Color(0XFFF3D733),
      onPrimaryContainer: Color(0XFFFFBB00),
      primaryContainer: Color(0XFFFFAF47),
      secondary: Colors.grey,
      onSecondary: Color(0XFF333232),
      onSecondaryContainer: Color(0XFF393939),
      background: Color(0XFFF5F5F5),
      onBackground: Color(0XFFFDF7D6),
      surface: Color(0XFFFFFFFF),
      onSurface: Color(0XFFFFE4C1),
      surfaceTint: Color(0XFFFFF7CF),
      onTertiary: Color(0XFF100818), //Main Text Color
      tertiary: Color(0XFF150a20), //Sub Text Color
      onTertiaryContainer: Color(0XFFe7e7e7), //TextField Border
      inversePrimary: Color(0XFF70C133),
      inverseSurface: Color(0XFF4AC71E),
      onSurfaceVariant: Color(0XFF2D4754),
      surfaceVariant: Color(0XFFFFCD5A),
      onInverseSurface: Color.fromARGB(255, 35, 61, 15),
      error: Colors.red,
      onErrorContainer: Color(0XFF620800),
      errorContainer: Color(0XFFA42B2B),
      onError: Colors.white,
      brightness: Brightness.light,
      secondaryContainer: Color.fromARGB(255, 97, 97, 97));

  ///Dark Theme Colors
  static ColorScheme darkColorScheme = const ColorScheme(
    primary: Color(0XFF5b298c), //  PRIMARY_COLOR
    onPrimary: Color(0XFFF3D733),
    onPrimaryContainer: Color(0XFFFFBB00),
    primaryContainer: Color(0XFFFFAF47),
    secondary: Colors.grey,
    // Color(0xFFec9410),
    onSecondary: Color(0xff9999aa),
    onSecondaryContainer: Color(0xff9999aa),
    onTertiary: Color(0xff9999aa), //Main Text Color
    tertiary: Color(0xff9999aa), //Sub Text Color
    onTertiaryContainer: Color(0XFFe7e7e7), //TextField Border
    background: Color(0xff151515),
    onBackground: Color(0x0DFFFFFF),
    surface: Color(0xff1E2746),
    onSurface: Colors.white,
    error: Colors.red,
    errorContainer: Colors.red,
    onError: Colors.white,
    brightness: Brightness.dark,
  );
}
