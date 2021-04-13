import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:hypeeo_app/app_config.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/bottom_navigation_widget.dart';
import 'package:hypeeo_app/constants.dart';
import 'package:hypeeo_app/models/app_user.dart';
import 'package:hypeeo_app/router/router.gr.dart';
import 'package:hypeeo_app/services/AppService.dart';
import 'package:hypeeo_app/text_widgets/search_text_field.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AppService _appService = AppService();

  AppUser? _appUser;

  String searchText = "";

  late AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 850),
    vsync: this,
  )..forward();

  late Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-0.2, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticInOut,
  ));

  @override
  void initState() {
    super.initState();

    try {
      getLoggedinUserInfo();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BackgroundWidget(
          child: Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                      child: BottomNavigationWidget(
                        onLoginSuccess: () {
                          setState(() {});
                        },
                      )),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 140, 30, 0),
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SlideTransition(
                                position: _offsetAnimation,
                                child: Image.asset("assets/logo.png")),
                            Image.asset(
                              "assets/dotted_border.png",
                              width: 420,
                              height: 320,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 5, 50, 20),
                            child: Text(
                              "INVEST IN YOUR FAVORITE STREAMER",
                              textAlign: TextAlign.center,
                              style:
                                  Theme.of(context).textTheme.headline6?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        fontFamily: "poppins",
                                      ),
                            ),
                          ),
                          SearchTextField(
                            text: searchText,
                            onChanged: (value) {
                              searchText = value;
                            },
                            hintText:
                                "Enter the twitch channel you're looking for",
                            onSuffixPressed: () async {

                              try {
                                FocusScope.of(context).unfocus();

                                if (_appUser?.email  == KADMIN_EMAIL) {
                                  showErrorSnackBar(context, "Admin cannot donate for streamers");
                                  return;
                                }

                                if (_appUser?.isStreamer  == true) {
                                  showErrorSnackBar(context, "Streamers are not allowed. May be in the future.");
                                  return;
                                }


                                searchStreamers();
                              } catch(e) {
                                print(e);
                              }

                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void searchStreamers() async {

    try {

      searchText = searchText.trim();

      if (searchText.isEmpty) {
        return;
      }

      Map<String, dynamic>? _map = await searchStreamer(searchText);

      AppUser? _usr = (_map != null) ? AppUser.map(_map) : null;

      if (_usr != null && _usr.isStreamer == true) {

        if (_appUser?.email  == KADMIN_EMAIL) {
          showErrorSnackBar(context, "Admin cannot donate for streamers");
          return;
        }

        if (_appUser?.isStreamer  == true) {
          showErrorSnackBar(context, "Streamers are not allowed. May be in the future.");
          return;
        }

        showProgress();

        Future.delayed(Duration(milliseconds: 400), () {

          if (FirebaseAuth.instance.currentUser == null) {
            _appService.loginAnonymously();
          }

          Provider.of<AppConfig>(context, listen: false)
              .selectedStreamer = _usr;

          hideProgress();

          context.router.push(
              StreamerDetailsRoute());
        });
      } else {
        showErrorSnackBar(context, 'No streamers found.');
      }

    } catch(e) {
      showErrorSnackBar(context, 'Something went wrong. Please try again');
      print("no streamer found...");
    }
  }

  Future<void> getLoggedinUserInfo() async {
    try {

      Map<String, dynamic>? _map = await _appService.retrieveLoggedinUserInfo();

      if (_map != null) {
        Provider.of<AppConfig>(context, listen: false).appUser =
            AppUser.map(_map);

        _appUser = AppUser.map(_map);

      } else if (FirebaseAuth.instance.currentUser != null) {
        Provider.of<AppConfig>(context, listen: false).appUser =
            AppUser.map({"email": FirebaseAuth.instance.currentUser.email});

        if (FirebaseAuth.instance.currentUser.email
            .contains(KADMIN_EMAIL)) {
          AppUser? user =
              Provider.of<AppConfig>(context, listen: false).appUser;

          if (user != null) {
            user.isAdmin = true;
            Provider.of<AppConfig>(context, listen: false).appUser = user;
            _appUser = user;
          }
        }
      }

      setState(() {});
    } catch (e) {
      print(e);
      hideProgress();
    }
  }

  Future<Map<String, dynamic>?> searchStreamer(String searchText) async {
    try {
      return await _appService.searchStreamerByName(searchText);
    } catch (e) {
      print(e);
    }
  }
}
