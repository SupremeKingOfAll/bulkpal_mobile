import 'package:flutter/material.dart';
import 'package:bulkpal_mobile/core/utils/app_colours.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColours.cardColour,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Color(0xFF00E5FF).withOpacity(0.01),
          width: 1.5,
        ),
      ),
      height: 50,
      width: 80,
      child: Container(
        height: 4,
        width: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: RadialGradient(
            colors: [
              AppColours.primaryColour,
              AppColours.primaryColour,
              AppColours.cardColour,
            ],
            radius: 1,
            stops: [0.38, 0.5, 0.9],
          ),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}

//
