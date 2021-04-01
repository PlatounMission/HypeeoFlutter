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
    return Container(color: kPrimaryColor, child: Center(child: Text("Retry page")), );
  }
}
