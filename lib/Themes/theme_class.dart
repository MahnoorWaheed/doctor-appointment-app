import 'package:flutter/material.dart';

class ThemeClass{
 
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Color.fromARGB(255, 33, 94, 145),
      secondary: Color.fromARGB(255, 33, 94, 145)
    ),
  
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 33, 94, 145),
      
    )
  );
 
}