import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    this.customPadding = EdgeInsets.zero,
    required this.customText,
    this.fontSize,
    this.fontWeight,
    this.myColour,
    super.key,
  });

  final EdgeInsets customPadding;
  final String customText;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? myColour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customPadding,
      child: Text(
        customText,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: myColour,
        ),
      ),
    );
  }
}
