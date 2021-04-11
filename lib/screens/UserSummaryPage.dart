import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/bottom_navigation_widget.dart';
import 'package:hypeeo_app/constants.dart';
import 'package:hypeeo_app/models/app_user.dart';
import 'package:hypeeo_app/models/token_purchases.dart';
import 'package:hypeeo_app/router/router.gr.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

import '../app_config.dart';

class UserSummaryPage extends StatefulWidget {
  @override
  _UserSummaryPageState createState() => _UserSummaryPageState();
}

class _UserSummaryPageState extends State<UserSummaryPage> {
  AppUser? _appUser;

  @override
  void initState() {
    super.initState();

    try {
      _appUser = Provider.of<AppConfig>(context, listen: false).appUser;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("user email is ${_appUser?.email ?? ""}");

    return BackgroundWidget(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 100, 0, 10),
                    child: Text(
                      "My account",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontFamily: "poppins",
                            fontWeight: FontWeight.w300,
                            fontSize: 30,
                          ),
                    ),
                  ),Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      _appUser?.email ?? "",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontFamily: "poppins",
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 180,
              left: 10,
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4, // 60% of space => (6/(6 + 4))
                      child: Container(
                        height: 40,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Streamer you support",
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      fontFamily: "poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2, // 40% of space
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Value & Qty",
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      fontFamily: "poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 250,
              left: 10,
              right: 0,
              bottom: 80,
              child: PaginateFirestore(
                  emptyDisplay: Center(child: Text("No data found")),
                  itemBuilderType: PaginateBuilderType.listView,
                  // listview and gridview
                  itemBuilder: (index, context, documentSnapshot) {
                    TokenPurchases _usr =
                        TokenPurchases.map(documentSnapshot.data());

                    return Container(
                      color: Colors.grey.withOpacity(0.03),
                      margin: EdgeInsets.only(bottom: 30),
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4, // 60% of space => (6/(6 + 4))
                                child: Container(
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        child: (_usr.photoUrl?.isEmpty == true)
                                            ? Image.asset(
                                                "assets/user.png",
                                                fit: BoxFit.cover,
                                                width: 80,
                                                height: 80,
                                              )
                                            : Image.network(
                                                _usr.photoUrl!,
                                                fit: BoxFit.cover,
                                                width: 80,
                                                height: 80,
                                              ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          constraints:
                                              BoxConstraints(maxWidth: 160),
                                          child: Text(
                                            "" + (_usr.twitchChannel ?? ""),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2, // 40% of space
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 200),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                          constraints:
                                              BoxConstraints(maxWidth: 160),
                                          child: Text(
                                            "\$" +
                                                (_usr.tokenPrice ?? 0)
                                                    .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                  fontFamily: "poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          constraints:
                                              BoxConstraints(maxWidth: 160),
                                          child: Text(
                                            formatDecimalValue(
                                                    _usr.tokenCount ?? 0) +
                                                " " +
                                                (_usr.tokenName ?? ""),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                  color: kButtonColor,
                                                  fontFamily: "poppins",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  query: FirebaseFirestore.instance
                      .collection('tokon_purchases')
                      .where("is_deleted", isEqualTo: false)
                      .where("user_email", isEqualTo: _appUser?.email)
                      .orderBy('date', descending: true),
                  isLive: true // to fetch real-time data
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 30, 5, 0),
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
                          size: 30,
                          color: Colors.white,
                        )),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          try {
                            FirebaseAuth.instance.signOut();

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
                          size: 30,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
