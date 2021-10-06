import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xff1f655d),
    accentColor: Color(0xff40bf7a),
    textTheme: TextTheme(
        headline6: TextStyle(color: Color(0xff40bf7a)),
        subtitle2: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Color(0xff40bf7a))),
    appBarTheme: AppBarTheme(color: Color(0xff1f655d)));

ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Color(0xfff5f5f5),
    accentColor: Color(0xff40bf7a),
    textTheme: TextTheme(
        headline6: TextStyle(color: Colors.black54),
        subtitle2: TextStyle(color: Colors.grey),
        subtitle1: TextStyle(color: Colors.white)),
    appBarTheme: AppBarTheme(
        color: Color(0xff1f655d),
        actionsIconTheme: IconThemeData(color: Colors.white)));

/// ----  Blue Theme  ----
final bluePrimary = Color(0xFF3F51B5);
final blueAccent = Color(0xFFFF9800);
final blueBackground = Color(0xFFFFFFFF);
final blueTheme = ThemeData(
    primaryColor: bluePrimary,
    accentColor: blueAccent,
    backgroundColor: blueBackground);

/// ----  Spooky Theme  ----
final spookyPrimary = Color(0xFF000000);
final spookyAccent = Color(0xFFBB86FC);
final spookyBackground = Color(0xFF4A4A4A);
final spookyTheme = ThemeData(
  primaryColor: spookyPrimary,
  accentColor: spookyAccent,
  backgroundColor: spookyBackground,
);

/// ----  Green Theme  ----
final greenPrimary = Color(0xFF4CAF50);
final greenAccent = Color(0xFF631739);
final greenBackground = Color(0xFFFFFFFF);
final greenTheme = ThemeData(
    primaryColor: greenPrimary,
    accentColor: greenAccent,
    backgroundColor: greenBackground);

/// ----  Pink Theme  ----
final pinkPrimary = Color(0xFFE91E63);
final pinkAccent = Color(0xFF0C7D9C);
final pinkBackground = Color(0xFFFFFFFF);
final pinkTheme = ThemeData(
    primaryColor: pinkPrimary,
    accentColor: pinkAccent,
    backgroundColor: pinkBackground);

enum ThemeType { Light, Dark }

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = darkTheme;
  ThemeType _themeType = ThemeType.Dark;

  toggleTheme() {
    if (_themeType == ThemeType.Dark) {
      currentTheme = lightTheme;
      _themeType = ThemeType.Light;
      return notifyListeners();
    }

    if (_themeType == ThemeType.Light) {
      currentTheme = darkTheme;
      _themeType = ThemeType.Dark;
      return notifyListeners();
    }
  }
}
