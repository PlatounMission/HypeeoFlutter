import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/rounded_button.dart';
import 'package:hypeeo_app/constants.dart';
import 'package:hypeeo_app/router/router.gr.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_config.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  bool isValidatedStreamers = false;

  @override
  Widget build(BuildContext context) {

    return BackgroundWidget(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Welclome Admin".toUpperCase(),
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontFamily: "poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Row(
                  children: [
                    TextButton(
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
            Positioned(
              top: 70,
              left: 10,
              right: 10,
              child: Container(
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          isValidatedStreamers = false;
                          setState(() {});
                        },
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.black,
                          side: BorderSide(
                              color: Colors.white,
                              width: isValidatedStreamers ? 0 : 1),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        child: Text("Un Verified Streamers"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          isValidatedStreamers = true;
                          setState(() {});
                        },
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.black,
                          side: BorderSide(
                              color: Colors.white,
                              width: isValidatedStreamers ? 1 : 0),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        child: Text("Verified Streamers"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 10,
              right: 10,
              bottom: 50,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PaginateFirestore(
                    key: UniqueKey(),
                    emptyDisplay: Center(child: Text("No data found")),
                    itemBuilderType: PaginateBuilderType.listView,
                    itemBuilder: (index, context, documentSnapshot) {
                      Map<String, dynamic> _map = documentSnapshot.data();

                      return Container(
                        color: Colors.grey.withOpacity(0.1),
                        margin: EdgeInsets.only(bottom: 50),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Streamers's Channel"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    child: Text(
                                      _map["twitch_channel"] ?? "",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () async {
                                      try {
                                        var _url =
                                            "twitch://stream/${_map["twitch_channel"] ?? ""}";
                                        var siteUrl =
                                            "https://www.twitch.tv/${_map["twitch_channel"] ?? ""}";
                                        await canLaunch(_url)
                                            ? await launch(_url)
                                            : await launch(siteUrl);
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Streamer Email "),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _map["email"] ?? "",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Streamer's Paypal "),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _map["paypal_link"] ?? "",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Streamer's Followers count "),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _map["no_of_followers"] ?? "",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Number of token to be issued "),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _map["number_of_token_issued"] ?? "",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Token Name"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "" + (_map["token_name"] ?? 0).toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Token Price"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "" + (_map["token_price"] ?? 0).toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: isValidatedStreamers == false,
                              child: Row(
                                children: [
                                  MaterialButton(
                                    onPressed: () async {
                                      try {
                                        showProgress();

                                        CollectionReference users =
                                            FirebaseFirestore.instance
                                                .collection('users');

                                        await users
                                            .doc(_map["email"] ?? "")
                                            .update({
                                          "is_streamer_validated": true
                                        });

                                        setState(() {});

                                        hideProgress();
                                      } catch (e) {
                                        print(e);
                                        hideProgress();
                                      }
                                    },
                                    child: Text("VALIDATE"),
                                    color: Colors.white,
                                    textColor: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  MaterialButton(
                                    onPressed: () async {
                                      try {
                                        showProgress();

                                        CollectionReference users =
                                            FirebaseFirestore.instance
                                                .collection('users');

                                        await users
                                            .doc(_map["email"] ?? "")
                                            .update({"is_deleted": true});

                                        setState(() {});
                                        hideProgress();
                                      } catch (e) {
                                        print(e);
                                        hideProgress();
                                      }
                                    },
                                    child: Text("DECLINE"),
                                    color: Colors.white,
                                    textColor: Colors.black,
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      );
                    },
                    query: FirebaseFirestore.instance
                        .collection('users')
                        .where("is_streamer_validated", isEqualTo: isValidatedStreamers)
                        .where("is_streamer", isEqualTo: true)
                        .where("is_deleted", isEqualTo: false)
                        .orderBy('twitch_channel'),
                    isLive: false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
