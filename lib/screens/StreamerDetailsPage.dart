import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hypeeo_app/common_widgets/background_view_widget.dart';
import 'package:hypeeo_app/common_widgets/login_footer.dart';
import 'package:hypeeo_app/common_widgets/rounded_button.dart';
import 'package:hypeeo_app/constants.dart';
import 'package:hypeeo_app/router/router.gr.dart';
import 'package:provider/provider.dart';

import '../app_config.dart';

class StreamerDetailsPage extends StatefulWidget {
  @override
  _StreamerDetailsPageState createState() => _StreamerDetailsPageState();
}

class _StreamerDetailsPageState extends State<StreamerDetailsPage>
    with TickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text(
                  "RESULT",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  "a hypeeo is currently on going here".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Token Issued",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontFamily: "poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      size: 18,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              Container(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "4 000 / 20 000",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontFamily: "poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  minHeight: 20,
                  valueColor: AlwaysStoppedAnimation<Color>(kButtonColor),
                  backgroundColor: Color(0xFF242444),
                  value: controller.value,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: Container(
                  color: Colors.red,
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fred Williams",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.white,
                          fontFamily: "poppins",
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                        ),
                  ),
                  IconButton(
                      icon: Icon(
                        FontAwesome.twitch,
                        color: kTwitchColor,
                      ),
                      onPressed: () {
                        //todo goto twitch account...
                      })
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  "45K Followers",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Color(0xFF535457),
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  '\$FRDW',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: kButtonColor,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  "Token Price : \$2",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.white,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RoundedButton(
                  title: "DONATE",
                  onTap: () {
                    context.router.push(StreamerDonateRoute());
                  }),
              Spacer(),
              LoginFooterWidget(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
