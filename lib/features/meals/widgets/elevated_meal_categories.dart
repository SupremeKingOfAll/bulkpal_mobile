import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ElevatedMealCategories extends StatefulWidget {
  const ElevatedMealCategories({
    required this.text,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  final String text;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<ElevatedMealCategories> createState() => _ElevatedMealCategoriesState();
}

class _ElevatedMealCategoriesState extends State<ElevatedMealCategories> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 45,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.isActive
                ? AppColours.navActive
                : AppColours.cardColour,
          ),
          child: Center(
            child: CustomText(
              customText: widget.text,
              myColour: widget.isActive
                  ? AppColours.primaryColour
                  : AppColours.textColour,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
