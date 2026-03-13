import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_icon.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/dashboard_view_model.dart';
import 'package:bulkpal_mobile/features/progress/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatCardHeroCard extends StatelessWidget {
  const StatCardHeroCard({
    required this.height,
    required this.width,
    required this.title,
    this.value,
    this.subTitle,
    required this.icon,
    required this.titleSize,
    this.valueSize,
    this.subTitleSize,
    required this.iconContainerHeight,
    required this.iconContainerWidth,
    required this.iconSize,
    super.key,
  });

  final String title;
  final String? value;
  final String? subTitle;
  final IconData icon;
  final double height;
  final double width;
  final double titleSize;
  final double? valueSize;
  final double? subTitleSize;
  final double iconContainerHeight;
  final double iconContainerWidth;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DashBoardViewModel>();
    return Container(
      padding: EdgeInsets.all(20),
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.09)),
        borderRadius: BorderRadius.circular(30),
        color: AppColours.cardColour.withOpacity(0.15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: titleSize)),
              CustomIcons(
                myIcon: icon,
                containerHeight: iconContainerHeight,
                containerWidth: iconContainerWidth,
                iconSize: iconSize,
                forceGradient: true,
              ),
            ],
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 1250 / 3000,
              minHeight: 10,
              backgroundColor: Colors.white.withOpacity(0.08),
              valueColor: AlwaysStoppedAnimation(AppColours.secondaryAccent),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (value != null)
                Text(
                  value!,
                  style: TextStyle(
                    fontSize: valueSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(width: 10),
              if (subTitle != null)
                Text(
                  subTitle!,
                  style: TextStyle(
                    fontSize: subTitleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(width: 10),
              Text(
                "${((1250 / 3000) * 100).toStringAsFixed(0)}% complete",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
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
