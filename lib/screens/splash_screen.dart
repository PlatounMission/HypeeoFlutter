import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hypeeo_app/app_config.dart';
import 'package:hypeeo_app/constants.dart';
import 'package:hypeeo_app/models/app_user.dart';
import 'package:hypeeo_app/router/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _isFirebaseInitialized = false;
  bool _isFirebaseInitializedError = false;
  Key key = UniqueKey();


  @override
  void initState() {
    super.initState();

    splashProgress();

    initializeData();

  }


  // Define an async function to initialize FlutterFire
  void initializeData() async {

    try {

      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();

      _isFirebaseInitialized = true;
    } catch(e) {
      print(e);
      // Set `_error` state to true if Firebase initialization fails
      _isFirebaseInitialized = false;
      _isFirebaseInitializedError = true;
    }


    //important line...
    hideProgress();

    if (_isFirebaseInitializedError) {
      Future.delayed(Duration(microseconds: 2), () async {
        print("_isFirebaseInitializedError $_isFirebaseInitializedError");

        AutoRouter.of(context).push(RetryWidgetRoute(onRetry: () {
          _isFirebaseInitializedError = false;
          initializeData();
        }, mesage: ""));

      });
    } else if (
          !_isFirebaseInitializedError && _isFirebaseInitialized
    ) {
        Future.delayed(Duration(microseconds: 2), () async {
          AutoRouter.of(context)
              .root.push(HomeRoute());
        });
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: kPrimaryColor
    );
  }
}
