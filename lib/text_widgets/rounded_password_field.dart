// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import '../constants.dart';
// import 'text_field_container.dart';
//
// class RoundedPasswordField extends StatefulWidget {
//
//   final ValueChanged<String>? onChanged;
//   final String? errorText;
//   final String? hintText;
//   final String? text;
//
//   RoundedPasswordField({
//     Key? key,
//     this.hintText,
//     this.onChanged,
//     this.errorText,
//     this.text = "",
//   }) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _RoundedPasswordFieldState();
// }
//
// class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
//
//   final TextEditingController textController = TextEditingController();
//
//   bool obscureText = true;
//
//   @override
//   Widget build(BuildContext context) {
//
//     textController.text = widget.text ?? "";
//
//     return Container(
//       height: 75,
//       child: Material(
//           color: Colors.transparent,
//         child: TextFieldContainer(
//           child: TextField(
//             controller: textController,
//             obscureText: obscureText,
//             onChanged: widget.onChanged,
//             cursorColor: kPrimaryColor,
//             style: TextStyle(
//             ),
//             decoration: new InputDecoration(
//                 errorStyle: TextStyle(
//                     fontSize: 15,
//                     height: 0.5
//                 ),
//                 suffixIcon: InkWell(
//                   onTap: () {
//                     print("kkk");
//                     setState(() {
//                       obscureText = !obscureText;
//                     });
//                   },
//                   child: Icon(
//                     obscureText ? Icons.visibility : Icons.visibility_off,
//                     color: kPrimaryColor,
//                     size: 15,
//                   ),
//                 ),
//                 prefixIcon: Icon(
//                   Icons.lock,
//                   color: kPrimaryColor,
//                 ),
//
//                 errorText: widget.errorText,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: BorderSide(
//                     width: 0.5,
//                     style: BorderStyle.none,
//                   ),
//                 ),
//                 filled: true,
//                 hintStyle: new TextStyle(color: Colors.grey[800]),
//                 hintText: widget.hintText,
//                 fillColor: Colors.white70
//             ),
//           ),
//         )
//       ),
//     );
//
//     Container(
//       height: 75,
//       child: Material(
//         color: Colors.transparent,
//         child: TextFieldContainer(
//           child: TextField(
//             controller: textController,
//             obscureText: obscureText,
//             onChanged: widget.onChanged,
//             cursorColor: kPrimaryColor,
//             decoration: InputDecoration(
//               errorText: widget.errorText,
//               errorMaxLines: 1,
//               errorStyle: TextStyle(
//                 fontSize: 12
//               ),
//               hintText: widget.hintText,
//               icon: Icon(
//                 Icons.lock,
//                 color: kPrimaryColor,
//               ),
//               suffix: InkWell(
//                 onTap: () {
//                   print("kkk");
//                   setState(() {
//                     obscureText = !obscureText;
//                   });
//                 },
//                 child: Icon(
//                   obscureText ? Icons.visibility : Icons.visibility_off,
//                   color: kPrimaryColor,
//                 ),
//               ),
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
