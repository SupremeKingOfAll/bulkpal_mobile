import 'package:flutter/material.dart';
import '../utils/app_colours.dart';

class CustomIcons extends StatelessWidget {
  const CustomIcons({required this.myIcon, super.key});

  final IconData myIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      decoration: BoxDecoration(
        color: AppColours.cardColour,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Color(0xFF00E5FF).withOpacity(0.01),
          width: 1.5,
        ),
      ),
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
            stops: [0.28, 0.15, 0.6],
          ),
        ),
        child: Icon(myIcon, color: AppColours.secondaryAccent),
      ),
    );
  }
}
