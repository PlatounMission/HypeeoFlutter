import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/rounded_button.dart';
import 'package:hypeeo_app/models/app_user.dart';
import 'package:hypeeo_app/services/AppService.dart';
import 'package:provider/provider.dart';

import '../app_config.dart';
import '../constants.dart';

class StreamerInfoEditPage extends StatefulWidget {

  final AppService _appService = AppService();

  late AppUser? _appUser;

  final Function? onEditSucceeded;

  StreamerInfoEditPage({this.onEditSucceeded});

  @override
  _StreamerInfoEditPageState createState() => _StreamerInfoEditPageState();
}

class _StreamerInfoEditPageState extends State<StreamerInfoEditPage> {

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String tokenName = "";
  String numberOfTokenToBeIssued = "";
  String tokenPrice = "";
  String paypalLink = "";

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 10),
                child: Text(
                  "SETUP your hypeeo".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w300,
                        fontSize: 32,
                      ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  tokenName = value;
                },
                style: TextStyle(color: Colors.white),
                decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'TOKEN NAME'.toUpperCase(),
                  hintStyle: TextStyle(
                      color: Colors.white, fontSize: 15, fontFamily: "poppins"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  numberOfTokenToBeIssued = value;
                },
                style: TextStyle(color: Colors.white),
                decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'NUMBER OF Token to be issued'.toUpperCase(),
                  hintStyle: TextStyle(
                      color: Colors.white, fontSize: 15, fontFamily: "poppins"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  tokenPrice = value;
                },
                style: TextStyle(color: Colors.white),
                decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'TOKEN PRICE'.toUpperCase(),
                  hintStyle: TextStyle(
                      color: Colors.white, fontSize: 15, fontFamily: "poppins"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  paypalLink = value;
                },
                style: TextStyle(color: Colors.white),
                decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'PAYPAL link'.toUpperCase(),
                  hintStyle: TextStyle(
                      color: Colors.white, fontSize: 15, fontFamily: "poppins"),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              RoundedButton(
                title: "SUBMIT",
                onTap: () async {
                  try {
                    if (tokenName.isEmpty) {
                      showErrorAlert(context, "", "Token name is missing");

                      return;
                    }

                    if (tokenPrice.isEmpty) {
                      showErrorAlert(context, "", "Token price is missing");

                      return;
                    }

                    if (numberOfTokenToBeIssued.isEmpty) {
                      showErrorAlert(context, "", "Number of token is missing");

                      return;
                    }

                    if (paypalLink.isEmpty) {
                      showErrorAlert(context, "", "Paypal link is missing");
                      return;
                    }

                    showProgress();

                    if (auth.currentUser != null) {
                      CollectionReference users =
                          FirebaseFirestore.instance.collection('users');

                      await users.doc(auth.currentUser.email).update({
                        "token_name": tokenName,
                        "token_price": tokenPrice,
                        "number_of_token_issued": numberOfTokenToBeIssued,
                        "paypal_link": paypalLink,
                        "is_streamer_validated": false,
                        "is_streamer": true
                      });

                      hideProgress();
                      context.router.pop();
                      widget.onEditSucceeded?.call();
                    } else {
                      hideProgress();
                      showErrorAlert(context, "",
                          "Something went wrong. Please contact administrator");
                    }
                  } catch (e) {
                    print(e);
                    hideProgress();

                    showErrorAlert(
                        context, "", "Something went wrong. Please try again");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
