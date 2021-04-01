import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:hypeeo_app/app_config.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/constants.dart';
import 'package:hypeeo_app/router/router.gr.dart';
import 'package:hypeeo_app/text_widgets/search_text_field.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  late AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 1), vsync: this,
  )..forward();

  late Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
        child: Container(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            print("on fan pressed...");

                            Provider.of<AppConfig>(context, listen: false).isStreamer = false;

                            context.router.push(LoginRoute());
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 5, 20, 10),
                            child: Text("I'M A FAN" ,
                              style: TextStyle(
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {

                            print("on streamer pressed...");

                            Provider.of<AppConfig>(context, listen: false).isStreamer = true;

                            context.router.push(LoginRoute());
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 8, 10),
                            child: Text("I'M A STREAMER",
                              style: TextStyle(
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
                  child: Container(
                    child: Column(
                      children: [
                        ScaleTransition(
                            scale: _animation,
                            child: Image.asset("assets/logo.png")
                        ),
                        Image.asset("assets/dotted_border.png", width: 420, height: 320,),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 5, 50, 20),
                            child: Text(
                              "INVEST IN YOUR FAVORITE STREAMER",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                fontFamily: "poppins",
                              ),
                            ),
                          ),
                          SearchTextField(
                            hintText: "Enter the streamer name you’re looking for",
                            onSuffixPressed: () {
                              //todo search for streamers from registered streamers...
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}




