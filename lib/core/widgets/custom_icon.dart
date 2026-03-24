import 'package:flutter/material.dart';
import '../utils/app_colours.dart';

class CustomIcons extends StatelessWidget {
  const CustomIcons({
    required this.containerWidth,
    required this.containerHeight,
    this.myIcon,
    required this.iconSize,
    this.text,
    this.isSelected = false,
    this.forceGradient = false,
    super.key,
  });

  final IconData? myIcon;
  final double containerHeight;
  final double containerWidth;
  final double iconSize;
  final String? text;
  final bool isSelected;
  final bool forceGradient;

  @override
  Widget build(BuildContext context) {
    final showCorrectGradient = forceGradient || isSelected;
    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        color: isSelected ? AppColours.cardColour : Color(0xFF02040A),
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
            colors: (showCorrectGradient ?? false)
                ? [
                    AppColours.iconBackground,
                    AppColours.iconBackground,
                    AppColours.cardColour,
                  ]
                : [Color(0xFF02040A), Color(0xFF02040A), Color(0xFF02040A)],
            radius: 1,
            stops: [0.28, 0.15, 0.6],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (myIcon != null)
              Icon(myIcon, color: AppColours.secondaryAccent, size: iconSize),
            if (text != null) Text(text!),
          ],
        ),
      ),
    );
  }
}
