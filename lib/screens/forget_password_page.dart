import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/rounded_button.dart';
import 'package:hypeeo_app/models/app_user.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../app_config.dart';
import '../constants.dart';

class ForgetPasswordPage extends StatefulWidget {

  ForgetPasswordPage();

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {

  FirebaseAuth auth = FirebaseAuth.instance;

  String email = "";

  @override
  void initState() {
    super.initState();
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
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Container(
                  child: Column(
                    children: [
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
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 80, 20, 10),
                        child: Text(
                          "Reset your password".toUpperCase(),
                          textAlign: TextAlign.center,
                          style:
                          Theme.of(context).textTheme.headline6?.copyWith(
                            fontFamily: "poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200,
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
                          hintText: 'Your Email'.toUpperCase(),
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "poppins"),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RoundedButton(
                          title: "RESET",
                          onTap: () async {
                            try {
                              if (email.isEmpty) {
                                showErrorAlert(
                                    context, "", "Email field is missing");

                                return;
                              }

                              showProgress();

                              await auth.sendPasswordResetEmail(email: email);

                              hideProgress();

                              showSuccessSnackBar(context, "Please check your email. Thank you!");

                              context.router.pop();

                            } on FirebaseAuthException catch (e) {
                              print(e);
                              hideProgress();
                              showErrorAlert(context, "",
                                  "Something went wrong. Please try again.");
                            } catch (e) {
                              print(e);

                              hideProgress();

                              showErrorAlert(context, "",
                                  "Something went wrong. Please try again.");
                            }
                          }),
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
}
