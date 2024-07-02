import 'package:flutter/material.dart';
import 'package:sushi_restaurant/theme/dark_theme.dart';
import 'package:sushi_restaurant/theme/light_theme.dart';

class ThemeNotifier extends ChangeNotifier {

  ThemeData _themeData = lightTheme;
  ThemeData get themeData => _themeData;
  bool get isDarkTheme => _themeData == darkTheme;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
      if(_themeData == lightTheme){
        _themeData = darkTheme;
      } else {
        _themeData = lightTheme;
      }
  }



}