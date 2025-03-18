import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final bool textinputtypephone;
  final maxLines;
  final onChanged;


  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.textinputtypephone,
    this.maxLines,
    this.onChanged

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        onChanged: onChanged,
        maxLines: obscureText ? 1 : maxLines,
        controller: controller,
        obscureText: obscureText,
        keyboardType: textinputtypephone ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), // Rounded corners for the border
              borderSide: BorderSide(
                color: Colors.black54, // Color of the border line
                width: 12.0, // Thickness of the border line
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners for focused border
              borderSide: BorderSide(
                color: Colors.blue, // Color when the TextField is focused
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners for enabled border
              borderSide: BorderSide(
                color: Colors.black54, // Color when the TextField is enabled (not focused)
                width: 2.0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 11.8, horizontal: 10),
            hintText: hintText,
            // hintStyle: TextStyle(color: Colors.black)
        ),
      ),
    );
  }
}
