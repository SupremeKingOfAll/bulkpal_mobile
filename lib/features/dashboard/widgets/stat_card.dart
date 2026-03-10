import 'package:flutter/material.dart';
import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_icon.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    required this.height,
    required this.width,
    required this.title,
    required this.value,
    required this.subTitle,
    this.icon,
    super.key,
  });

  final String title;
  final String value;
  final String subTitle;
  final IconData? icon;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.09)),
        borderRadius: BorderRadius.circular(30),
        color: AppColours.cardColour.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: AppColours.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColours.textColour,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subTitle,
            style: const TextStyle(color: AppColours.textSecondary),
          ),
        ],
      ),
    );
  }
}
