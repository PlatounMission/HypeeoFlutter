import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/bottom_navigation_widget.dart';
import 'package:hypeeo_app/common_widgets/rounded_button.dart';
import 'package:hypeeo_app/models/app_user.dart';
import 'package:provider/provider.dart';

import '../app_config.dart';
import '../constants.dart';

class StreamerDonatePage extends StatefulWidget {
  @override
  _StreamerDonatePageState createState() => _StreamerDonatePageState();
}

class _StreamerDonatePageState extends State<StreamerDonatePage> {
  AppUser? selectedStreamer;
  AppUser? appUser;

  double donationAmount = 0;
  double amountOfTokenTobeReceived = 1230;

  String? email;
  String? password;

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future initData() async {
    try {
      if (appUser == null) {
        appUser = Provider.of<AppConfig>(context, listen: false).appUser;
      }

      if (selectedStreamer == null) {
        selectedStreamer =
            Provider.of<AppConfig>(context, listen: false).selectedStreamer;
      }

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                          child: Text(
                            "A hypeeo is currently on going here".toUpperCase(),
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
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(130)),
                          child: Image.asset(
                            "assets/user.png",
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
                              "Fred Williams",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
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
                                onPressed: () {
                                  //todo goto twitch account...
                                })
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                            visible: (appUser == null ||
                                appUser!.isAnynymous == true),
                            child: Column(
                              children: [
                                TextField(
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                  decoration: new InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    hintText: 'Email'.toUpperCase(),
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "poppins"),
                                  ),
                                  onChanged: (value) => email = value,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  style: TextStyle(color: Colors.white),
                                  obscureText: true,
                                  decoration: new InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    hintText: 'Password'.toUpperCase() +
                                        " (Optional)",
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "poppins"),
                                  ),
                                  onChanged: (value) => password = value,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 30, 50, 30),
                                  child: Text(
                                    "Please note that theee informations will be used to your account. If the informations are erroned, you may not receive your tokens.",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                          fontFamily: "poppins",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                        ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "I donate to Fred:", //todo name add here..
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      fontFamily: "poppins",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF393A3E),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              double amount = 0;

                              try {
                                amount = double.parse(value);
                              } catch (e) {
                                print(e);
                              }

                              donationAmount = amount;

                              amountOfTokenTobeReceived = 20;

                              setState(() {});
                            },
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: true, signed: true),
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 20, 0, 20),
                              suffixIcon: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text('USD')),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "I will receive:", //todo name add here..
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      fontFamily: "poppins",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF393A3E),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: TextField(
                            controller: TextEditingController(
                                text:
                                    "" + amountOfTokenTobeReceived.toString()),
                            enabled: false,
                            style: TextStyle(color: Colors.white),
                            decoration: new InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 20, 0, 20),
                              suffixIcon: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text('\$FRDW')),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Visibility(
                          visible: true,
                          child: RoundedButton(
                            title: "DONATE",
                            onTap: () {
                              try {
                                print(appUser);
                                print(email);
                                print(password);
                                if (donationAmount == 0) {
                                  return;
                                }

                                if (amountOfTokenTobeReceived <= 0) {
                                  return;
                                }
                                if (appUser?.email == null &&
                                    (email == null || email!.isEmpty)) {
                                  return;
                                }

                                CollectionReference purchases =
                                    FirebaseFirestore.instance
                                        .collection("tokon_purchases");

                                purchases.add({
                                  "user_email": appUser?.email ?? email,
                                  "unit_price":
                                      selectedStreamer?.tokenPrice ?? 0,
                                  "streamer_email":
                                      selectedStreamer?.email ?? "",
                                  "donation_amount": donationAmount,
                                  "token_count": amountOfTokenTobeReceived,
                                  "date": DateTime.now()
                                });

                                context.router.pop();
                              } catch (e) {
                                print(e);
                              }

                              //amountOfTokenTobeReceived
                            },
                          ),
                        ),
                        Visibility(
                          visible: (appUser != null && appUser!.isAnynymous == false),
                          child: SizedBox(height: 100,),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future createUserAccount(String email, String password) async{
    try {

      showProgress();

      UserCredential _credz = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(
          email: email, password: password);

      if (FirebaseAuth.instance.currentUser.isAnonymous) {
        try {
          await FirebaseAuth.instance.currentUser
              .linkWithCredential(_credz.credential);
        } catch (e) {
          print(e);
        }
      }

    } catch(e) {
      print(e);
    }
  }
}
