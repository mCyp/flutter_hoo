import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hoo/common/constant/baseConstant.dart';
import 'package:flutter_hoo/common/utils/sp_util.dart';

extension ThemeModeExtension on ThemeMode{
  String get value => ['System','Light','Dark'][index];
}

class ThemeProvider extends ChangeNotifier{

  void syncTheme(){
    final String theme = SpUtil.getString(BaseConstant.theme);
    if(theme.isNotEmpty && theme != ThemeMode.system.value){
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode){
    SpUtil.putString(BaseConstant.theme, themeMode.value);
    notifyListeners();
  }

  ThemeMode getThemeMode(){
    final String theme = SpUtil.getString(BaseConstant.theme);
    switch(theme){
      case "Dark":
        return ThemeMode.dark;
      case "Light":
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}