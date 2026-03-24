import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TitleMealCards extends StatelessWidget {
  const TitleMealCards({
    required this.title,
    required this.value,
    required this.progressValue,
    required this.progressColour,
    super.key,
  });

  final String title;
  final double value;
  final double progressValue;
  final Color progressColour;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 100,
      width: 120,
      decoration: BoxDecoration(
        color: AppColours.cardColour,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(customText: title),
          SizedBox(height: 10),
          CustomText(customText: value.toString()),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 10,
              backgroundColor: AppColours.textColour.withOpacity(0.08),
              valueColor: AlwaysStoppedAnimation(progressColour),
            ),
          ),
        ],
      ),
    );
  }
}
