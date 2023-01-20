import 'package:flutter/material.dart';
import 'package:task_app/Constants/colors.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: 16, color: darkTextColorTheme),
      bodyText2: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: darkTextColorTheme),
    ),
    scaffoldBackgroundColor: darkColorTheme,
    colorScheme: ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 16, color: lightTextColorTheme),
        bodyText2: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: lightTextColorTheme),
      ),
      scaffoldBackgroundColor: lightColorTheme,
      colorScheme: ColorScheme.light());
}
