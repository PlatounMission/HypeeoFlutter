import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/rounded_button.dart';
import 'package:provider/provider.dart';

import '../app_config.dart';
import '../constants.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  String loginDesc = "";

  bool isStreamer = false;

  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    isStreamer = Provider.of<AppConfig>(context).isStreamer;

    if (isStreamer) {
      loginDesc = "Please note that your account will need to be verified before appearing on the app ".toUpperCase();
    } else {
      loginDesc = "Please note that the information provided need to be accurate in order to transfer your tokens".toUpperCase();
    }

    return BackgroundWidget(
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
                      padding: const EdgeInsets.fromLTRB(0, 80, 0, 10),
                      child: Text(
                        Provider.of<AppConfig>(context).isStreamer ? "LOGIN AS A STREAMER" : "LOGIN AS A FAN",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
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
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontFamily: "poppins",
                          fontWeight: FontWeight.w200,
                          fontSize: 10,
                        ),
                      ),
                    ),

                    SizedBox(height: 100,),

                    TextField(
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      ),
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
                            fontFamily: "poppins"
                          ),
                      ),
                    ),
                    SizedBox(height: 20,),

                    TextField(
                      style: TextStyle(
                          color: Colors.white
                      ),
                      decoration: new InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: 'Password'.toUpperCase(),
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "poppins"
                        ),
                      ),
                    ),

                    SizedBox(height: 80,),
                    RoundedButton(title: "LOGIN", onTap: () {
                      context.router.pop();
                    }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
