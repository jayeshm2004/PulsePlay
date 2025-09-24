import 'package:flutter/material.dart';

class AppTheme{
  static OutlineInputBorder _border(Color color)=>OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),

          );
  static final darkThemeMode=ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(27),
        enabledBorder: _border(Colors.white),
        focusedBorder: _border(Colors.pink),
  
        ),
      );
  
}