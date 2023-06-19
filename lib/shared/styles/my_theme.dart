import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/shared/styles/text_styles.dart';
import 'app_colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: purple,
      primaryColor: primaryColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: darkPurple,
        unselectedItemColor: Colors.grey.shade400,
      ),
      textTheme: TextTheme(
        bodySmall: Robto12Black(),
        bodyMedium: elMissiryMid(),
        bodyLarge: poppins18Light(),
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white, size: 35),
        backgroundColor: darkPurple,
      ));
  static ThemeData darkTheme = ThemeData();
}