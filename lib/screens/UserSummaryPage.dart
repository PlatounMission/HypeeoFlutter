import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/bottom_navigation_widget.dart';
import 'package:hypeeo_app/router/router.gr.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

import '../app_config.dart';

class UserSummaryPage extends StatefulWidget {
  @override
  _UserSummaryPageState createState() => _UserSummaryPageState();
}

class _UserSummaryPageState extends State<UserSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
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
              ),
            ),
            Positioned(
              top: 180,
              left: 10,
              child: Container(
                color: Colors.green,
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
                                      fontWeight: FontWeight.normal,
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
                                      fontWeight: FontWeight.normal,
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
              right: 10,
              bottom: 80,
              child: PaginateFirestore(
                  itemBuilderType: PaginateBuilderType.listView, // listview and gridview
                  itemBuilder: (index, context, documentSnapshot) => ListTile(
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Text(documentSnapshot.data()['name']),
                    subtitle: Text(documentSnapshot.id),
                  ),
                  query: FirebaseFirestore.instance.collection('users').orderBy('name'),
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
                        )
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          try {

                            FirebaseAuth.instance.signOut();

                            Provider.of<AppConfig>(context, listen: false)
                                .appUser = null;
                            Provider.of<AppConfig>(context, listen: false)
                                .selectedStreamer = null;

                            context.router.pushAndRemoveUntil(HomeRoute(), predicate: (_)=> false);

                          } catch(e) {
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
