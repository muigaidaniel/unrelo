import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: 'AbeeZee',
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: 15.sp, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 12.sp, color: Colors.white),
      bodySmall: TextStyle(fontSize: 12.sp, color: Colors.white),
      titleLarge: TextStyle(
          fontSize: 21.sp, color: Colors.white, fontWeight: FontWeight.bold),
    ),
    primarySwatch: Colors.blue,
  );
}
