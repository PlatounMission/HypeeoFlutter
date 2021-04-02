import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:hypeeo_app/app_config.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/login_footer.dart';
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
    duration: const Duration(milliseconds: 850),
    vsync: this,
  )..forward();

  // late Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.fastOutSlowIn,
  // );

  late Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-0.2, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticInOut,
  ));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Container(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                child: LoginFooterWidget(
                  onFanTxtLabelTapped: () {
                    print("on fan pressed...");
                    Provider.of<AppConfig>(context, listen: false).isStreamer =
                        false;
                    context.router.push(LoginRoute());
                  },
                  onStreamerTxtLabelTapped: () {
                    print("on streamer pressed...");
                    Provider.of<AppConfig>(context, listen: false).isStreamer =
                        true;
                    context.router.push(LoginRoute());
                  },
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
                      SlideTransition(
                          position: _offsetAnimation,
                          child: Image.asset("assets/logo.png")
                      ),
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
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      fontFamily: "poppins",
                                    ),
                          ),
                        ),
                        SearchTextField(
                          hintText:
                              "Enter the streamer name you’re looking for",
                          onSuffixPressed: () {
                            context.router.push(StreamerDetailsRoute());

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
