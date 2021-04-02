import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_config.dart';

class LoginFooterWidget extends StatefulWidget {

  final GestureTapCallback? onFanTxtLabelTapped;
  final GestureTapCallback? onStreamerTxtLabelTapped;

  LoginFooterWidget({this.onFanTxtLabelTapped, this.onStreamerTxtLabelTapped});

  @override
  _LoginFooterWidgetState createState() => _LoginFooterWidgetState();
}

class _LoginFooterWidgetState extends State<LoginFooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          children: [
            InkWell(
              onTap: widget.onFanTxtLabelTapped,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 20, 10),
                child: Text("I'M A FAN" ,
                  style: TextStyle(
                  ),
                ),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: widget.onStreamerTxtLabelTapped,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 10),
                child: Text("I'M A STREAMER",
                  style: TextStyle(
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
