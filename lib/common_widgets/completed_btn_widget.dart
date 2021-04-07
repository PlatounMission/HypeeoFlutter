import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CompletedButtonWidget extends StatefulWidget {

  final String? title;
  CompletedButtonWidget({this.title});

  @override
  _CompletedButtonWidgetState createState() => _CompletedButtonWidgetState();
}

class _CompletedButtonWidgetState extends State<CompletedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Material(
        shadowColor: Colors.grey[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),
        elevation: 6.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(29.0)),
              color: Color(0xFF000000),
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF660E11),
                  blurRadius: 20.0,
                  spreadRadius: 6.0,
                ),
              ]
          ),
          child: Material(
            type: MaterialType.transparency,
            elevation: 6.0,
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(29.0)),
              splashColor: Colors.white30,
              onTap: () {},
              child: Container(
                width: 200,
                height: 60,
                padding: EdgeInsets.all(13.0),
                child: Center(
                  child: Text(
                    widget.title ?? "OK",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "poppoins"
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
