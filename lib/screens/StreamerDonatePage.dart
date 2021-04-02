import 'package:flutter/material.dart';

class StreamerDonatePage extends StatefulWidget {
  @override
  _StreamerDonatePageState createState() => _StreamerDonatePageState();
}

class _StreamerDonatePageState extends State<StreamerDonatePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black,

      child:                   TextField(
        style: TextStyle(
            color: Colors.white
        ),
        decoration: new InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:  BorderSide(color: Colors.white ),

            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:  BorderSide(color: Colors.white ),

            ),
            border: new OutlineInputBorder(
              borderSide:  BorderSide(color: Colors.white ),
            ),
            hintText: 'Tell us about yourself',
            hintStyle: TextStyle(
                color: Colors.white
            ),
            labelText: 'Username',
            labelStyle: TextStyle(
                color: Colors.white
            ),
            suffixText: 'USD',
            suffixStyle: const TextStyle(color: Colors.green)),
      ),
    );
  }
}
