import 'package:flutter/material.dart';
import '../utils/app_colours.dart';

class CustomIcons extends StatelessWidget {
  const CustomIcons({
    required this.containerWidth,
    required this.containerHeight,
    required this.myIcon,
    required this.iconSize,
    super.key,
  });

  final IconData myIcon;
  final double containerHeight;
  final double containerWidth;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        color: AppColours.cardColour,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Color(0xFF00E5FF).withOpacity(0.01),
          width: 1.5,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: RadialGradient(
            colors: [
              AppColours.iconColour,
              AppColours.iconColour,
              AppColours.cardColour,
            ],
            radius: 1,
            stops: [0.28, 0.15, 0.6],
          ),
        ),
        child: Icon(myIcon, color: AppColours.secondaryAccent, size: iconSize),
      ),
    );
  }
}
