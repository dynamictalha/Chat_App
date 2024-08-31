import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.grey.shade600,
      secondary: const Color.fromARGB(255, 74, 73, 73),
      tertiary: Colors.grey.shade800,
      inversePrimary: Colors.grey.shade300
    ),
    scaffoldBackgroundColor: const Color(0xFF242426), // Set the Scaffold body color here
);