import 'package:flutter/material.dart';
import 'package:flutter_hoo/style/theme/colors.dart';
import 'package:flutter_hoo/style/theme/styles.dart';

class ThemeCenter {
  static ThemeData getCenterTheme({bool isDark = false}) {
    return ThemeData(
        errorColor: isDark ? CustomColors.dark_red : CustomColors.red,
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: isDark
            ? CustomColors.dark_primary_color
            : CustomColors.primary_color,
        accentColor: isDark
            ? CustomColors.dark_primary_color
            : CustomColors.primary_color,
        indicatorColor: isDark
            ? CustomColors.dark_primary_color
            : CustomColors.primary_color,
        scaffoldBackgroundColor:
            isDark ? CustomColors.dark_bg_color : CustomColors.bg_color,
        canvasColor:
            isDark ? CustomColors.dark_bg_color : CustomColors.bg_color,
        unselectedWidgetColor: isDark ? CustomColors.dark_unselected_item_color : CustomColors.unselected_item_color,
        textSelectionColor: CustomColors.primary_color.withAlpha(70),
        textSelectionHandleColor: CustomColors.primary_color,
        textTheme: TextTheme(
            headline1:
                isDark ? TextStyles.dark_headLine1 : TextStyles.headLine1,
            headline2:
                isDark ? TextStyles.dark_headline2 : TextStyles.headline2,
            headline3:
                isDark ? TextStyles.dark_headline3 : TextStyles.headline3,
            headline4:
                isDark ? TextStyles.dark_headline4 : TextStyles.headline4,
            headline5:
                isDark ? TextStyles.dark_headline5 : TextStyles.headline5,
            headline6:
                isDark ? TextStyles.dark_headline6 : TextStyles.headline6,
            bodyText1:
                isDark ? TextStyles.dark_bodyText1 : TextStyles.bodyText1,
            bodyText2:
                isDark ? TextStyles.dark_bodyText2 : TextStyles.bodyText2,
            subtitle1:
                isDark ? TextStyles.dark_subtitle1 : TextStyles.subtitle1,
            subtitle2:
                isDark ? TextStyles.dark_subtitle2 : TextStyles.subtitle2,
            caption: isDark ? TextStyles.dark_caption : TextStyles.caption,
            button: isDark ? TextStyles.dark_button : TextStyles.button),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: isDark ? TextStyles.dark_hint : TextStyles.hint),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: isDark ? CustomColors.dark_bg_color : CustomColors.bg_color,
    ));
  }
}

