import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

TextStyle Robto12Black()=> GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color:  Colors.black);

TextStyle poppins18Light()=> GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: primaryColor
);

TextStyle elMissiryMid()=> GoogleFonts.elMessiri(
    fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor);