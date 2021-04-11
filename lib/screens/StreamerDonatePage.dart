import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/bottom_navigation_widget.dart';
import 'package:hypeeo_app/common_widgets/rounded_button.dart';
import 'package:hypeeo_app/models/app_user.dart';
import 'package:hypeeo_app/screens/paypal_payment.dart';
import 'package:hypeeo_app/services/AppService.dart';
import 'package:provider/provider.dart';

import '../app_config.dart';
import '../constants.dart';

class StreamerDonatePage extends StatefulWidget {
  final Function? onSuccesfulDonation;

  StreamerDonatePage(this.onSuccesfulDonation);

  @override
  _StreamerDonatePageState createState() => _StreamerDonatePageState();
}

class _StreamerDonatePageState extends State<StreamerDonatePage> {
  AppService _appService = AppService();

  AppUser? _streamer;

  AppUser? appUser;

  double donationAmount = 0;

  double amountOfTokenTobeReceived = 0;

  double tokenPurchasedQtyUptoNow = 0;

  String? email;

  String? password;

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future initData() async {
    try {
      try {
        appUser = Provider.of<AppConfig>(context, listen: false).appUser;

        _streamer =
            Provider.of<AppConfig>(context, listen: false).selectedStreamer;

        tokenPurchasedQtyUptoNow =
            await _appService.calculateNumberOfTokenPurchased(
                _streamer!.email!, appUser!.email!);
      } catch (e) {
        print(e);
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
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
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _streamer?.twitchChannel ?? "",
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
                                  openTwitch(_streamer?.twitchChannel ?? "");
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
                                      const EdgeInsets.fromLTRB(50, 20, 50, 20),
                                  child: Text(
                                    "Please note that theee informations will be used to your account. If the informations are erroned, you may not receive your tokens.",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                          fontFamily: "poppins",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 11,
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
                            "I donate to ${_streamer?.twitchChannel ?? ""}:",
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
                              _calcualteTheTokenAmountToBeReceived();
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
                                text: "" +
                                    formatDecimalValue(
                                        amountOfTokenTobeReceived)),
                            enabled: false,
                            style: TextStyle(color: Colors.white),
                            decoration: new InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 20, 0, 20),
                              suffixIcon: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(_streamer?.tokenName ?? "")),
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
                            onTap: () async {
                              try {
                                if (donationAmount == 0) {
                                  return;
                                }

                                if (amountOfTokenTobeReceived <= 0) {
                                  return;
                                }
                                if (appUser?.email == null &&
                                    (email == null || email!.isEmpty)) {

                                  showErrorSnackBar(context, "Your email is missing");
                                  return;
                                }

                                if (_streamer != null &&
                                    (_streamer?.paypalLink ?? "") == "" ) {
                                  showErrorSnackBar(context, "Something went wrong. please try again.");
                                  return;
                                }

                                print("donation amount $donationAmount ");

                                CollectionReference apiDetails =
                                    FirebaseFirestore.instance
                                        .collection("api_details");

                                DocumentSnapshot snapshot =
                                    await apiDetails.doc("paypal").get();

                                Map<String, dynamic> _map = snapshot.data();

                                    Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => PaypalPayment(
                                      clientId: _map["client_id"],
                                      clientSecret: _map["client_secret"],
                                      price: donationAmount,
                                      streamerPaypal: _streamer?.paypalLink ?? "",
                                      onFinish: (PaymentStatus status) async {
                                        // payment done

                                        if (status == PaymentStatus.SUCCESS) {

                                          CollectionReference purchases =
                                              FirebaseFirestore.instance
                                                  .collection("tokon_purchases");

                                          purchases.add({
                                            "user_email": appUser?.email ?? email,
                                            "token_price":
                                                _streamer?.tokenPrice ?? 0,
                                            "streamer_email":
                                            _streamer?.email ?? "",
                                            "donation_amount": donationAmount,
                                            "token_count": amountOfTokenTobeReceived,
                                            "token_name": _streamer?.tokenName ?? "",
                                            "twitch_channel": _streamer?.twitchChannel ?? "",
                                            "is_deleted": false,
                                            "photo_url": _streamer?.photoUrl ?? "",
                                            "date": DateTime.now()
                                          });

                                          Future.delayed(Duration(milliseconds: 10), (){
                                            widget.onSuccesfulDonation?.call();
                                            context.router.pop();
                                          });

                                        } else {
                                          showErrorSnackBar(context, "Payment cancelled");
                                        }

                                      },
                                    ),
                                  ),
                                );

                              } catch (e) {
                                print(e);
                              }

                              //amountOfTokenTobeReceived
                            },
                          ),
                        ),
                        Visibility(
                          visible: (appUser != null &&
                              appUser!.isAnynymous == false),
                          child: SizedBox(
                            height: 100,
                          ),
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

  void _calcualteTheTokenAmountToBeReceived() {
    try {
      double tokenPrice = _streamer?.tokenPrice ?? 0;

      if (donationAmount > 0 && tokenPrice > 0) {
        amountOfTokenTobeReceived = (donationAmount / tokenPrice);
      } else {
        amountOfTokenTobeReceived = 0;
      }
    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Future createUserAccount(String email, String password) async {
    try {
      showProgress();

      if (FirebaseAuth.instance.currentUser.isAnonymous) {
        try {
          await FirebaseAuth.instance.currentUser.delete();
        } catch (e) {
          print(e);
          showProgress();
        }
      }

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      showProgress();
    }
  }
}
