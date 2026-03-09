import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bulkpal_mobile/core/utils/app_colours.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true, //decreases the shadows
      scaffoldBackgroundColor: AppColours.primaryColour,
      cardColor: AppColours.cardColour,
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: AppColours.textColour,
        displayColor: Colors.transparent,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
