import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final appThemeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
      primaryColor: const Color(0xFF3B62FF),
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF3B62FF),
        primary: const Color(0xFF3B62FF),
        secondary: Colors.blueAccent,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: GoogleFonts.poppinsTextTheme());
});
