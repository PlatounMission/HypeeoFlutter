import 'package:flutter/material.dart';


class BackgroundWidget extends StatelessWidget {

  late final Widget? child;

  BackgroundWidget({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: child,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/shape.png"),
            fit: BoxFit.cover,
          )
      ),
    );
  }
}