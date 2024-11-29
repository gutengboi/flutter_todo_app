import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color whiteClr = Colors.white;
const Color primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);


class Themes{
  static final light= ThemeData(
    scaffoldBackgroundColor: whiteClr,
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );

  static final dark= ThemeData(
    scaffoldBackgroundColor: darkGreyClr,
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color:Get.isDarkMode?Colors.grey[400]:Colors.grey
    )
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color:Get.isDarkMode?Colors.white:Colors.black
      )
  );
}