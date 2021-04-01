import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:hypeeo_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GlobalConfiguration().loadFromAsset("global_configurations");

  runApp(HypeeoApp());
}
