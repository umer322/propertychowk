import 'package:flutter/material.dart';
import 'package:propertychowk/utils/colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primaryColorLight: Colors.grey[400],
    primaryColorDark: Colors.black,
    canvasColor: Colors.white,
    appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black)
    ),
    primaryColor: primaryColor,
    accentColor: Colors.grey[400],
    hintColor: Colors.grey,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionHandleColor: primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200],
      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(30)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor),borderRadius: BorderRadius.circular(30)),
      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(30)),
      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(30))
    ),
    primarySwatch: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
    buttonColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed) || states.contains(MaterialState.hovered))
                return Colors.black;
              return primaryColor;
            },
          ),
        )
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black12,
    accentColor: Colors.deepOrangeAccent,
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
    backgroundColor: Colors.black,
    hintColor: Colors.deepOrangeAccent,
    bottomAppBarColor: Colors.grey,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}