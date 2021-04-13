import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/rounded_button.dart';
import 'package:hypeeo_app/models/app_user.dart';
import 'package:hypeeo_app/router/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../app_config.dart';
import '../constants.dart';

class LoginPage extends StatefulWidget {

  bool isStreamer;

  final Function(bool refreshContentOnly)? onLoginSuccess;

  LoginPage({required this.isStreamer, this.onLoginSuccess});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String loginDesc = "";

  String email = "";
  String password = "";
  String twitchChannel = "";
  String numberOfFollowers = "";

  bool shouldSignup = true;

  bool obscureText = true;

  @override
  void initState() {
    super.initState();

    initData();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isStreamer) {
      loginDesc =
          "Please note that your account will need to be verified before appearing on the app "
              .toUpperCase();
    } else {
      loginDesc =
          "Please note that the information provided need to be accurate in order to transfer your tokens"
              .toUpperCase();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BackgroundWidget(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Container(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/dotted_border.png",
                        width: 400,
                        height: 300,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 80, 0, 10),
                        child: Text(
                          shouldSignup
                              ? "SIGNUP"
                              : "LOGIN",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          loginDesc,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w200,
                                    fontSize: 10,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        onChanged: (value) {
                          email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        decoration: new InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Email'.toUpperCase(),
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "poppins"),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: obscureText,
                        style: TextStyle(color: Colors.white),
                        decoration: new InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: Icon(
                              obscureText ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText:
                              'Password'.toUpperCase() + "  (6 or more digits)",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "poppins"),
                        ),
                      ),
                      Visibility(
                        visible: widget.isStreamer && shouldSignup,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            TextField(
                              onChanged: (value) {
                                twitchChannel = value;
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: new InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: 'Twitch channel'.toUpperCase(),
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: "poppins"),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (value) {
                                numberOfFollowers = value;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white),
                              decoration: new InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: 'NUMBER OF FOLLOWERs'.toUpperCase(),
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: "poppins"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RoundedButton(
                          title: shouldSignup ? "SIGN UP" : "LOGIN",
                          onTap: () async {
                            try {
                              if (email.isEmpty) {
                                showErrorAlert(
                                    context, "", "Email field is missing");

                                return;
                              }
                              if (password.isEmpty) {
                                showErrorAlert(
                                    context, "", "Password field is missing");

                                return;
                              }

                              if (widget.isStreamer) {
                                if (twitchChannel.isEmpty) {
                                  showErrorAlert(context, "",
                                      "Twitch channel field is missing");

                                  return;
                                }

                                if (numberOfFollowers.isEmpty) {
                                  showErrorAlert(context, "",
                                      "Number of followers field is missing");

                                  return;
                                }
                              }

                              showProgress();

                              if (auth.currentUser != null &&
                                  auth.currentUser.isAnonymous) {
                                try {
                                  await auth.currentUser.delete();

                                  print(
                                      "current user is ${auth.currentUser.email}");
                                } catch (e) {
                                  print(e);
                                }
                              } else if (auth.currentUser != null) {
                                await auth.signOut();
                              }

                              UserCredential _credz = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                      email: email, password: password);

                              if (_credz.user != null) {
                                CollectionReference users =
                                    firestore.collection('users');

                                if (widget.isStreamer) {

                                  try {
                                    DocumentSnapshot _exist = await users.doc(email).get();
                                    if (!_exist.exists) {
                                      await users.doc(email).set({
                                        "twitch_channel": twitchChannel,
                                        "no_of_followers": numberOfFollowers,
                                        "email": email,
                                        "photo_url": "",
                                        "is_streamer_validated": false,
                                        "is_streamer": true,
                                      });
                                    }
                                  } catch (e) {
                                    print(e);
                                    hideProgress();
                                    showErrorAlert(context, "",
                                        "Something went wrong. Please contact administrator");
                                    return;
                                  }
                                } else {

                                  DocumentSnapshot _exist = await users.doc(email).get();
                                  if (!_exist.exists) {
                                    await users.doc(email).set({
                                      "email": email,
                                      "is_streamer": false,
                                      "is_deleted": false,
                                    });
                                  }
                                }

                                hideProgress();
                                context.router.pop();

                                if (!widget.isStreamer) {
                                  widget.onLoginSuccess?.call(true);
                                } else {
                                  widget.onLoginSuccess?.call(false);
                                }

                                initData();


                              } else {
                                hideProgress();
                              }

                              // //setup local user...
                              // Provider.of<AppConfig>(context, listen: false)
                              //     .appUser = AppUser.map({
                              //   "twitch_channel": twitchChannel,
                              //   "no_of_followers": numberOfFollowers,
                              //   "email": email,
                              //   "is_streamer_validated": false,
                              //   "is_streamer": widget.isStreamer,
                              // });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                hideProgress();

                                showErrorAlert(context, "",
                                    "Please check your password. If you are a new user, try to use a strong password.");
                              } else if (e.code == 'email-already-in-use') {
                                loginWithExistingCrdentials(email, password,
                                    () {
                                  hideProgress();
                                  context.router.pop();

                                  widget.onLoginSuccess?.call(true);

                                });
                              } else {
                                hideProgress();
                                showErrorAlert(context, "",
                                    "Something went wrong. Please try again.");
                              }
                            } catch (e) {
                              print(e);

                              hideProgress();

                              showErrorAlert(context, "",
                                  "Something went wrong. Please try again.");
                            }
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        visible: true,
                        child: GestureDetector(
                          child: Text("Forgot Password?"),
                          onTap: () {

                            context.router.replace(ForgetPasswordRoute());
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        visible: shouldSignup,
                        child: GestureDetector(
                          child: Text("Already have an account?"),
                          onTap: () {

                            showProgress();

                            Future.delayed(Duration(milliseconds: 400), () {
                              hideProgress();
                              setState(() {
                                widget.isStreamer = false;
                                shouldSignup = false;
                              });
                            });

                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: TextButton(
                      onPressed: () {
                        try {
                          context.router.pop();
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: Colors.white,
                      )),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> loginWithExistingCrdentials(
      String email, String password, Function? callback) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      DocumentReference _docRef = users.doc(email);

      DocumentSnapshot snapshot = await _docRef.get();

      if (snapshot.exists) {
        Map<String, dynamic> _map = snapshot.data();

        Provider.of<AppConfig>(context, listen: false).appUser =
            AppUser.map(_map);

        print(
            "user assign to provider  ${Provider.of<AppConfig>(context, listen: false).appUser?.email ?? "m..."}");
      } else {
        if (auth.currentUser != null) {
          Provider.of<AppConfig>(context, listen: false).appUser =
              AppUser.map({"email": email});
        }
      }
      callback?.call();
    } catch (e) {
      print(e);
      showErrorSnackBar(context, "Please try again");
      hideProgress();
    }
  }

  Future initData() async {
    try {

      String email = auth.currentUser?.email ?? "";

      CollectionReference users =
      FirebaseFirestore.instance.collection('users');

      DocumentReference _docRef = users.doc(email);

      DocumentSnapshot snapshot = await _docRef.get();

      if (snapshot.exists) {
        Map<String, dynamic> _map = snapshot.data();

        Provider.of<AppConfig>(context, listen: false).appUser =
            AppUser.map(_map);

      }
    } catch(e) {
      print(e);
    }
  }
}
