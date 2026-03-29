import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    required this.title,
    required this.subTitle,
    required this.colour,
    super.key,
  });

  final String title;
  final String subTitle;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 100,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColours.cardColour,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            customText: title,
            fontWeight: FontWeight.bold,
            myColour: AppColours.textColour.withOpacity(0.5),
          ),
          SizedBox(height: 10),
          CustomText(
            customText: subTitle,
            fontWeight: FontWeight.bold,
            myColour: colour,
            fontSize: 22,
          ),
        ],
      ),
    );
  }
}
