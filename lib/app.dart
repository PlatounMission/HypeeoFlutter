import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hypeeo_app/router/router.gr.dart';
import 'package:hypeeo_app/theme.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_config.dart';
import 'constants.dart';


class HypeeoApp extends StatefulWidget {
  @override
  _HypeeoAppState createState() => _HypeeoAppState();
}

class _HypeeoAppState extends State<HypeeoApp> {

  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    // );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppConfig>.value(value: AppConfig()),
      ],
      child: Selector<AppConfig, ThemeMode>(
        selector: (context, appConfig) => appConfig.themeMode,
        builder: (context, themeMode, child) {

          var initialRoute = <PageRouteInfo>[SplashScreenRoute()];

          return MaterialApp.router(
            theme: lightThemeData(context),
            themeMode: ThemeMode.light,
            builder: EasyLoading.init(),
            routerDelegate: _appRouter.delegate(
                initialRoutes: initialRoute
            ),
            routeInformationParser: _appRouter.defaultRouteParser(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}




