import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../themes/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  static const String themeBoxName = 'theme_box';
  static const String themeKey = 'is_dark_mode';

  late bool _isDarkMode;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _isDarkMode = Hive.box<bool>(themeBoxName).get(themeKey, defaultValue: false) ?? false;
  }

  ThemeData get themeData => _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    Hive.box<bool>(themeBoxName).put(themeKey, _isDarkMode);
    notifyListeners();
  }

  static ThemeProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ThemeProvider>(context, listen: listen);
  }
} 