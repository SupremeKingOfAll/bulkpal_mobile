import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_icon.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class MealCards extends StatelessWidget {
  const MealCards({
    required this.myIcon,
    required this.title,
    required this.subTitle,
    required this.colour,
    required this.calories,
    super.key,
  });

  final IconData myIcon;
  final String title;
  final String subTitle;
  final Color colour;
  final double calories;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 400,
      height: 100,
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
              color: colour.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              height: 80,
              width: 80,
              child: Icon(myIcon, color: colour),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                customText: title,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                customText: subTitle,
                myColour: AppColours.textColour.withOpacity(0.5),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                customText: calories.toString(),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Text(
                'KCAL',
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
