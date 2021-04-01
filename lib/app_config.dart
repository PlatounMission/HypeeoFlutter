import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class AppConfig with ChangeNotifier {

  //current theme
  ThemeMode _currentTheme = ThemeMode.system;

  ThemeMode get themeMode => _currentTheme;

  set themeMode(ThemeMode theme) {
    _currentTheme = theme;
    notifyListeners();
  }


  //isStreamaer...
  bool _isStreamer = false;

  get isStreamer => _isStreamer;

  set isStreamer(streamer) {
    _isStreamer = streamer;
  }


}
