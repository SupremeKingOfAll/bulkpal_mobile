import 'package:bulkpal_mobile/core/widgets/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:bulkpal_mobile/core/utils/app_colours.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    this.text,
    required this.ContainerWidth,
    required this.ContainerHeight,
    this.MyIcon,
    required this.IconSize,
    required this.isSelected,
    this.forceGradient = false,
    super.key,
  });

  final String? text;
  final double ContainerWidth;
  final double ContainerHeight;
  final IconData? MyIcon;
  final double IconSize;
  final bool isSelected;
  final bool forceGradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? AppColours.secondaryAccent
            : Colors.white.withOpacity(0.1),
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
            colors: isSelected
                ? [
                    AppColours.primaryColour,
                    AppColours.surfaceHighlight,
                    AppColours.cardColour,
                  ]
                : [Color(0xFF02040A), Color(0xFF02040A), Color(0xFF02040A)],
            radius: 1,
            stops: [0.38, 0.5, 0.9],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (MyIcon != null)
              CustomIcons(
                containerWidth: ContainerWidth,
                containerHeight: ContainerHeight,
                myIcon: MyIcon!,
                iconSize: IconSize,
                isSelected: isSelected,
                forceGradient: forceGradient,
              ),
          ],
        ),
      ),
    );
  }
}

//
