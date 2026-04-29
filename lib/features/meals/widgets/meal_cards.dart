import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:flutter/material.dart';

class MealCards extends StatelessWidget {
  const MealCards({
    required this.MyIcon,
    required this.Title,
    required this.SubTitle,
    required this.Colour,
    required this.TrailingValue,
    required this.TrailingLabel,
    super.key,
  });

  final IconData MyIcon;
  final String Title;
  final String SubTitle;
  final Color Colour;
  final String TrailingValue;
  final String TrailingLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 400,
      height: 110,
      decoration: BoxDecoration(
        color: AppColours.cardColour,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colour.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(MyIcon, color: Colour),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColours.textColour,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  SubTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColours.textColour.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                TrailingValue,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColours.textColour,
                ),
              ),
              Text(
                TrailingLabel,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColours.textColour.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
