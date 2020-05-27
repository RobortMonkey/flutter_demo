import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/common/common.dart';
import 'package:flutterapp/res/colors.dart';
import 'package:flutterapp/res/styles.dart';

class ThemeProvider extends ChangeNotifier {
  static const Map<ThemeMode, String> themes = {
    ThemeMode.dark: 'Dart',
    ThemeMode.light: 'Light',
    ThemeMode.system: 'System'
  };
  int count = 0;

  void plus() {
    count++;
    notifyListeners();
  }

  void subtract() {
    count--;
    notifyListeners();
  }

  void syncTheme() {
    var theme = SpUtil.getString(Constant.theme);
    if (theme.isNotEmpty && theme != themes[ThemeMode.system]) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) {
    SpUtil.putString(Constant.theme, themes[themeMode]);
    notifyListeners();
  }

  /**
   * 获取当前主题类型
   */
  ThemeMode getThemeMode() {
    var theme = SpUtil.getString(Constant.theme);
    switch (theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData getTheme({bool isDarkMode: false}) {
    return ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        accentColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // Tab指示器颜色
        indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // 页面背景色
        scaffoldBackgroundColor:
            isDarkMode ? Colours.dark_bg_color : Colors.white,
        // 主要用于Material背景色
        canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
        textSelectionColor: Colours.app_main.withAlpha(70),
        textSelectionHandleColor: Colours.app_main,
        textTheme: TextTheme(
          // TextField输入文字颜色
          subtitle1: isDarkMode ? TextStyles.textDark : TextStyles.text,
          // Text文字样式
          bodyText2: isDarkMode ? TextStyles.textDark : TextStyles.text,
          subtitle2:
              isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle:
              isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: isDarkMode ? Colours.dark_bg_color : Colors.white,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        dividerTheme: DividerThemeData(
            color: isDarkMode ? Colours.dark_line : Colours.line,
            space: 0.6,
            thickness: 0.6),
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ));
  }
}
