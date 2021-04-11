import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hypeeo_app/constants.dart';
import 'package:hypeeo_app/models/app_user.dart';
import 'package:hypeeo_app/router/router.gr.dart';
import 'package:provider/provider.dart';

import '../app_config.dart';

class BottomNavigationWidget extends StatefulWidget {
  final GestureTapCallback? onLoginSuccess;

  BottomNavigationWidget({this.onLoginSuccess});

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppConfig>(
      builder: (context, appConfig, child) {
        return appConfig.appUser == null ||
                appConfig.appUser?.isAnynymous == true
            ? Container(
                width: double.infinity,
                height: 40.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {

                          context.router.push(LoginRoute(
                              isStreamer: false,
                              onLoginSuccess: () {
                                setState(() {});
                                widget.onLoginSuccess?.call();
                              }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 20, 10),
                          child: Text(
                            "I'M A FAN",
                            style: TextStyle(),
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          print("on streamer pressed...");
                          context.router.push(LoginRoute(
                              isStreamer: true,
                              onLoginSuccess: () {
                                try {
                                  context.router.push(StreamerInfoEditRoute(
                                      onEditSucceeded: () {
//streamer has signed up. now show the homepage...
                                    context.router.pushAndRemoveUntil(StreamerDetailsRoute(), predicate: (_) => false,);
                                  }));
                                } catch (e) {
                                  print(e);
                                }
                              }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                          child: Text(
                            "I'M A STREAMER",
                            style: TextStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                height: 60.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {

                          if (AutoRouter.of(context).current!.name ==
                              HomeRoute.name) {
                            return;
                          }

                          context.router.push(HomeRoute());
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 20, 10),
                          child: Icon(
                            Icons.search_outlined,
                            size: 30,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          AppUser? _user =
                              Provider.of<AppConfig>(context, listen: false)
                                  .appUser;

                          if (_user != null) {
                            if (_user.isAnynymous == true) {
                              return;
                            }

                            if (_user.email == KADMIN_EMAIL) {
                              context.router.push(AdminRoute());
                              return;
                            }

                            if (_user.isStreamer == true) {
                              context.router.push(StreamerDetailsRoute());
                              return;
                            } else if (_user.email != "") {
                              context.router.push(UserSummaryRoute());
                              return;
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                          child:
                              Icon(FontAwesome.user, color: Color(0xFF5957D8)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
