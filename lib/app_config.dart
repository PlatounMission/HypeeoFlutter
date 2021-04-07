import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:hypeeo_app/models/app_user.dart';

class AppConfig with ChangeNotifier {

  //current user
  AppUser? _currentAppUser;

  AppUser? get appUser => _currentAppUser;

  set appUser(AppUser? u) {
    _currentAppUser = u;
    notifyListeners();
  }

  //current theme
  ThemeMode _currentTheme = ThemeMode.system;
  ThemeMode get themeMode => _currentTheme;

  set themeMode(ThemeMode theme) {
    _currentTheme = theme;
    notifyListeners();
  }




  //selected streamer...
  AppUser? _selectedStreamer;
  AppUser? get selectedStreamer => _selectedStreamer;

  set selectedStreamer(AppUser? u) {
    _selectedStreamer = u;
    notifyListeners();
  }

}
