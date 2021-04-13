import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/bottom_navigation_widget.dart';
import 'package:hypeeo_app/common_widgets/completed_btn_widget.dart';
import 'package:hypeeo_app/common_widgets/rounded_button.dart';
import 'package:hypeeo_app/constants.dart';
import 'package:hypeeo_app/models/app_user.dart';
import 'package:hypeeo_app/router/router.gr.dart';
import 'package:hypeeo_app/services/AppService.dart';
import 'package:provider/provider.dart';

import '../app_config.dart';

class StreamerDetailsPage extends StatefulWidget {
  StreamerDetailsPage();

  @override
  _StreamerDetailsPageState createState() => _StreamerDetailsPageState();
}

class _StreamerDetailsPageState extends State<StreamerDetailsPage>
    with TickerProviderStateMixin {
  AppService _appService = AppService();

  AppUser? appUser;
  AppUser? _streamer;
  double numberOfTokenPurchased = 0;
  double progressValue = 0;

  AnimationController? controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        if (progressValue <= controller!.value) {
          controller!.stop();
        }
        setState(() {});
      });

    try {
      appUser = Provider.of<AppConfig>(context, listen: false).appUser;

      _streamer =
          Provider.of<AppConfig>(context, listen: false).selectedStreamer;

      tokenPurchasedCount(_streamer!);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (_streamer == null) {
      if (appUser?.isStreamer == true) {
        _streamer = appUser;
      }
    }

    return BackgroundWidget(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
          child: Stack(
            children: [

              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                        child: Text(
                          "RESULT",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "a hypeeo is currently on going here".toUpperCase(),
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "Token Issued",
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      fontFamily: "poppins",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.info_outline,
                              size: 18,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "${formatDecimalToString(numberOfTokenPurchased)} / ${formatDecimalToString(_streamer?.numberOfTokenIssued ?? 0)}",
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          minHeight: 20,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kButtonColor),
                          backgroundColor: Color(0xFF242444),
                          value: controller?.value,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(130)),
                        child: (_streamer?.photoUrl?.isEmpty == true)
                            ? Image.asset(
                                "assets/user.png",
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              )
                            : Image.network(
                                _streamer!.photoUrl!,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _streamer?.twitchChannel ?? "",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Colors.white,
                                      fontFamily: "poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                          ),
                          IconButton(
                              icon: Icon(
                                FontAwesome.twitch,
                                color: kTwitchColor,
                              ),
                              onPressed: () async {
                                openTwitch(_streamer?.twitchChannel ?? "");
                              })
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          "${shortenNumber(_streamer?.numberOfFollowers ?? 0)} Followers",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: Color(0xFF535457),
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: Text(
                          _streamer?.tokenName ?? "",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: kButtonColor,
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "Token Price : \$" +
                              (_streamer?.tokenPrice ?? 0).toString(),
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: Colors.white,
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      (appUser != null &&
                              (appUser?.isStreamer == true) &&
                              (appUser?.isStreamerValidated == false))
                          ? Column(
                              children: [
                                Text("You account is being verified.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                          fontFamily: "poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        )),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      (appUser != null && (appUser?.isStreamer == true))
                          ? RoundedButton(
                              title: "EDIT",
                              onTap: () {
                                context.router.push(
                                    StreamerInfoEditRoute(onEditSucceeded: () {
                                  //streamer has signed up. now show the homepage...
                                }));
                              })
                          : showCompleteOrDonateButton(),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavigationWidget(
                  onLoginSuccess: () {
                    setState(() {});
                  },
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Visibility(
                  visible: (appUser?.isStreamer == true),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      children: [
                        Spacer(),
                        TextButton(
                            onPressed: () async {
                              try {

                                await FirebaseAuth.instance.signOut();

                                Provider.of<AppConfig>(context, listen: false)
                                    .appUser
                                    ?.isAnynymous = true;

                                Provider.of<AppConfig>(context, listen: false)
                                    .appUser = null;
                                Provider.of<AppConfig>(context, listen: false)
                                    .selectedStreamer = null;

                                context.router.pushAndRemoveUntil(HomeRoute(),
                                    predicate: (_) => false);
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Icon(
                              Icons.logout,
                              size: 25,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showCompleteOrDonateButton() {
    if (numberOfTokenPurchased < (_streamer?.numberOfTokenIssued ?? 0)) {
      return RoundedButton(
          title: "DONATE",
          onTap: () {
            context.router.push(StreamerDonateRoute(onSuccesfulDonation: () {

              if (_streamer != null) {
                tokenPurchasedCount(_streamer!);
              }

              Future.delayed(Duration(milliseconds: 500), (){
                showSuccessSnackBar(context, "Donation succesful!");
              });
            }));
          });
    } else {
      return CompletedButtonWidget(
        title: "COMPLETED",
      );
    }
  }

  Future tokenPurchasedCount(AppUser streamer) async {

    numberOfTokenPurchased = await _appService.calculateNumberOfTokenPurchased(
        streamer.email!);

    progressValue = calculateProgressBarValue(
        numberOfTokenPurchased, _streamer!.numberOfTokenIssued ?? 0);

    controller!.forward();
  }
}
