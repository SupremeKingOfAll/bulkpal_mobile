import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BottomSettingsCard extends StatelessWidget {
  const BottomSettingsCard({
    required this.myIcon,
    required this.title,
    required this.subTitle,
    super.key,
  });

  final IconData myIcon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 350,
      decoration: BoxDecoration(
        color: AppColours.iconBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColours.iconBackground,
              ),
              child: Icon(myIcon, color: AppColours.navActive),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                customText: title,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                customText: subTitle,
                myColour: AppColours.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.keyboard_arrow_right,
            size: 25,
            color: AppColours.textColour,
          ),
        ],
      ),
    );
  }
}
