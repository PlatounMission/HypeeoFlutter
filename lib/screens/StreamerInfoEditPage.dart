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
  AppUser? _streamer;

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String tokenName = "";
  String numberOfTokenToBeIssued = "";
  String tokenPrice = "";
  String paypalLink = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fillExistingInfo();
  }

  fillExistingInfo() async {
    Map<String, dynamic>? _map = await AppService().retrieveLoggedinUserInfo();

    if (_map != null) {
      Provider.of<AppConfig>(context, listen: false).appUser =
          AppUser.map(_map);

      _streamer = AppUser.map(_map);

      tokenName = _streamer?.tokenName ?? "";

      numberOfTokenToBeIssued = (_streamer?.numberOfTokenIssued == 0
              ? "" : _streamer?.numberOfTokenIssued).toString();

      tokenPrice =
          (_streamer?.tokenPrice == 0 ? "" : _streamer?.tokenPrice).toString();
      paypalLink = _streamer?.paypalLink ?? "";

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.all(0),
                  child: TextButton(
                      onPressed: () {
                        try {
                          context.router.pop();
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.white,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                  controller: TextEditingController(text: tokenName),
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
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    numberOfTokenToBeIssued = value;
                  },
                  controller: TextEditingController(
                      text: (numberOfTokenToBeIssued == 0)
                          ? ""
                          : numberOfTokenToBeIssued),
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
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(text: tokenPrice),
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
                  controller: TextEditingController(text: paypalLink),
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
                          "is_streamer": true,
                          "is_deleted": false,
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
      ),
    );
  }
}
