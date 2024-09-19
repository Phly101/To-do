import 'package:flutter/material.dart';


class MyThemeData{
static const Color primaryColor = Color(0xff5D9CEC);
static const Color darkPrimaryColor = Color(0xff060E1E);
static const Color accentColor = Color(0xffDFECDB);
static const Color greenPrimary = Color(0xff61E757);
static const Color darkSecondary = Color(0xff141922);




static ThemeData lightTheme = ThemeData(

  scaffoldBackgroundColor: accentColor,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: primaryColor,
    titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),

  ),



  useMaterial3: false,
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,

    ),
    titleSmall: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.normal,

    ),

    titleLarge:  TextStyle(
    fontSize: 22,
    color: Colors.white,
    fontWeight: FontWeight.bold,

  ),
    bodyMedium:  TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.normal,

    ),

  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    elevation: 0
  ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),

    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor,
      primary:  primaryColor,
      onPrimary: Colors.white,
      secondary: greenPrimary,
      onSecondary: Colors.black,
    )

);
static ThemeData darkTheme = ThemeData(


  scaffoldBackgroundColor: darkPrimaryColor,
  useMaterial3: false,
  textTheme: const TextTheme(

    titleLarge:  TextStyle(
      fontSize: 22,
      color: darkPrimaryColor,
      fontWeight: FontWeight.bold,

    ),

    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,

    ),
    titleSmall: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.normal,

    ),
    bodyMedium:  TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.normal,

    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.white,
    backgroundColor: darkSecondary,
    elevation: 0
  ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: darkSecondary,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor,
      primary: primaryColor,
      onPrimary: darkPrimaryColor,
      secondary: greenPrimary,
      onSecondary: darkSecondary,
    )

);



}
