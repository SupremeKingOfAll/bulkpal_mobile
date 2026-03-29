import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class HeroProgressCard extends StatelessWidget {
  const HeroProgressCard({
    required this.myIcon,
    required this.colour,
    super.key,
  });

  final IconData myIcon;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 390,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColours.cardColour,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                customText: "Avg calories",
                myColour: AppColours.textColour.withOpacity(0.5),
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                customText: "2,850",
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CustomText(
              customText: "kcal",
              fontWeight: FontWeight.bold,
              myColour: AppColours.textColour.withOpacity(0.5),
            ),
          ),
          Spacer(),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: colour.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(myIcon, color: colour),
          ),
        ],
      ),
    );
  }
}
