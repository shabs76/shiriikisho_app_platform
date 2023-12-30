import 'package:flutter/material.dart';

class TextFieldNoIcon extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int minLines;
  final int maxlines;
  final bool expand;
  final Color borderColor;
  final Color focusedColor;
  final Color fillcolor;
  final TextStyle labelStyles;
  final TextInputType type;
  final String hintTextz;
  final bool ishowing;
  const TextFieldNoIcon({
    super.key,
    required this.controller,
    this.ishowing = false,
    required this.borderColor,
    required this.fillcolor,
    required this.focusedColor,
    required this.labelStyles,
    required this.labelText,
    this.expand = false,
    this.type = TextInputType.text,
    required this.maxlines,
    required this.minLines,
    this.hintTextz = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style:
              labelStyles.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          maxLines: maxlines,
          minLines: minLines,
          expands: expand,
          controller: controller,
          obscureText: ishowing,
          keyboardType: type,
          decoration: InputDecoration(
              hintText: hintTextz,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  const EdgeInsets.only(left: 13.0, right: 5.0, top: 17.0),
              label: Text(labelText),
              labelStyle: labelStyles.copyWith(
                  color: borderColor, fontSize: 0, letterSpacing: 0, height: 0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: borderColor),
                borderRadius: BorderRadius.circular(6.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: focusedColor),
                borderRadius: BorderRadius.circular(6.0),
              ),
              fillColor: fillcolor,
              filled: true),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
