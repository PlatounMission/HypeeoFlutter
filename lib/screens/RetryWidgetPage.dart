import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RetryWidgetPage extends StatefulWidget {

  final Function? onRetry;
  final String mesage;

  RetryWidgetPage(this.onRetry, this.mesage);

  @override
  _RetryWidgetPageState createState() => _RetryWidgetPageState();
}

class _RetryWidgetPageState extends State<RetryWidgetPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Column(
        children: [
          Center(
              child: Text("Retry page")
          ),
          MaterialButton(
            height: 60,
            minWidth: 200,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(22)),
            onPressed: () {
              try {
                widget.onRetry?.call();
              } catch(e) {
                print(e);
              }
              context.router.pop();
            },
            child: Text(
              "Please try again",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
