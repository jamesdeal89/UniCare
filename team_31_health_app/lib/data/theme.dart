import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  // This is the theme of your application.
  //
  // TRY THIS: Try running your application with "flutter run". You'll see
  // the application has a purple toolbar. Then, without quitting the app,
  // try changing the seedColor in the colorScheme below to Colors.green
  // and then invoke "hot reload" (save your changes or press the "hot
  // reload" button in a Flutter-supported IDE, or press "r" if you used
  // the command line to start the app).
  //
  // Notice that the counter didn't reset back to zero; the application
  // state is not lost during the reload. To reset the state, use hot
  // restart instead.
  //
  // This works for code too, not just values: Most code changes can be
  // tested with just a hot reload.
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: Colors.black, fontFamily: 'CupertinoSystemDisplay'),
    bodyLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'CupertinoSystemDisplay'),
    bodyMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black, fontFamily: 'CupertinoSystemDisplay'),
  ),
  iconTheme: IconThemeData(
    color: Color.fromRGBO(16, 38, 59, 1),
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: const Color.fromRGBO(192, 196, 255, 1),
    onPrimary: Colors.black,
    onPrimaryContainer: Color.fromRGBO(191, 211, 231, 1),
    onPrimaryFixedVariant: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.black,
    tertiary: Color.fromRGBO(68, 142, 202, 1),
    onTertiary: Color.fromRGBO(28, 28, 30, 1),
    onTertiaryFixed: Color.fromRGBO(190, 112, 27, 1),
    error: Color.fromRGBO(213, 0, 0, 1),
    onError: Colors.redAccent,
    surface: Color.fromRGBO(242, 242, 247, 1),
    onSurface: Color.fromARGB(255, 36, 36, 38),
  ),

  inputDecorationTheme: InputDecorationTheme(fillColor: Color.fromRGBO(68, 142, 202, 0.6), hintStyle: TextStyle(color: Colors.grey)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Color.fromRGBO(4, 49, 95, 1)),

  useMaterial3: true,
);

ThemeData darkMode = ThemeData(
  // This is the theme of your application.
  //
  // TRY THIS: Try running your application with "flutter run". You'll see
  // the application has a purple toolbar. Then, without quitting the app,
  // try changing the seedColor in the colorScheme below to Colors.green
  // and then invoke "hot reload" (save your changes or press the "hot
  // reload" button in a Flutter-supported IDE, or press "r" if you used
  // the command line to start the app).
  //
  // Notice that the counter didn't reset back to zero; the application
  // state is not lost during the reload. To reset the state, use hot
  // restart instead.
  //
  // This works for code too, not just values: Most code changes can be
  // tested with just a hot reload.
  textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'CupertinoSystemDisplay'),
    bodyLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'CupertinoSystemDisplay'),
    bodyMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'CupertinoSystemDisplay'),
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromRGBO(16, 38, 59, 1),
    onPrimary: Colors.white,
    onPrimaryFixed: Color.fromRGBO(10, 132, 255, 1),
    onPrimaryContainer: Color.fromRGBO(35, 52, 69, 1),
    onPrimaryFixedVariant: Colors.black,
    secondary: Colors.black,
    onSecondary: Colors.white,
    tertiary: Color.fromRGBO(7, 92, 134, 1),
    onTertiary: Color.fromRGBO(236, 173, 255, 1),
    onTertiaryFixed: Color.fromRGBO(190, 112, 27, 1),
    onTertiaryFixedVariant: Color.fromARGB(255, 181, 181, 181),
    error: Color.fromRGBO(213, 0, 0, 1),
    onError: Colors.redAccent,
    surface: Color.fromRGBO(13, 30, 47, 1),
    onSurface: Color.fromARGB(255, 199, 199, 199),
  ),
  inputDecorationTheme: InputDecorationTheme(fillColor: Color.fromRGBO(8, 54, 97, 1), hintStyle: TextStyle(color: Colors.grey)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Color.fromRGBO(10, 132, 255, 1)),

  useMaterial3: true,
);
