import 'package:flutter/material.dart';
import '../constants.dart';

class SearchTextField extends StatelessWidget {

  final TextEditingController textController = TextEditingController();

  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSuffixPressed;
  final String? errorText;
  final String? text;
  final TextInputType textInputType;


  SearchTextField({
    Key? key,
    this.hintText,
    this.icon = Icons.search,
    this.onChanged,
    this.onSuffixPressed,
    this.errorText,
    this.text = "",
    this.textInputType = TextInputType.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (text != "") {
      textController.text = text ?? "";
    }


    return Container(
      height: 50,
      child: Material(
        color: Colors.transparent,
          child: TextField(
            maxLines: 1,
            keyboardType: TextInputType.name,
            onChanged: onChanged,
            controller: textController,
            cursorColor: kPrimaryColor,
            style: TextStyle(
            ),
            decoration: new InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(
                      icon,
                      color: kPrimaryColor,
                    ),
                    onPressed: onSuffixPressed
                ),
                errorText: errorText,
                errorStyle: TextStyle(
                  fontSize: 15,
                  height: 0.5
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 0.5,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintStyle: new TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                  fontWeight: FontWeight.w300
                ),
                hintText: hintText,
                fillColor: Colors.white
            ),
          )
      ),
    );


  }
}