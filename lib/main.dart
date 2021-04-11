import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hypeeo_app/app.dart';

void main() async {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // status bar color
    statusBarBrightness: Brightness.dark,//status bar brigtness
    statusBarIconBrightness:Brightness.dark , //status barIc
    // systemNavigationBarColor: Colors.blue, // navigation bar color// on Brightness
    // systemNavigationBarDividerColor: Colors.greenAccent,//Navigation bar divider color
    // systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));

  WidgetsFlutterBinding.ensureInitialized();

  runApp(HypeeoApp());
}
