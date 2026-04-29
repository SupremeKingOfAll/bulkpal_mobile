import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_icon.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/dashboard_view_model.dart';
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
    required this.totalCalories,
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
  final int totalCalories;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DashBoardViewModel>();

    return Container(
      padding: const EdgeInsets.all(16),
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.09)),
        borderRadius: BorderRadius.circular(30),
        color: AppColours.cardColour,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomIcons(
                myIcon: icon,
                containerHeight: iconContainerHeight,
                containerWidth: iconContainerWidth,
                iconSize: iconSize,
                forceGradient: true,
              ),
            ],
          ),

          const Spacer(),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (value != null)
                Text(
                  value!,
                  style: TextStyle(
                    fontSize: valueSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(width: 8),
              if (subTitle != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    subTitle!,
                    style: TextStyle(
                      fontSize: subTitleSize ?? 18,
                      fontWeight: FontWeight.bold,
                      color: AppColours.textSecondary,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: vm.ProgressValue(totalCalories),
              minHeight: 8,
              backgroundColor: AppColours.textColour.withOpacity(0.08),
              valueColor: AlwaysStoppedAnimation(AppColours.secondaryAccent),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "${vm.ProgressPercentage(totalCalories)}% of daily target",
            style: const TextStyle(
              color: AppColours.accentColour,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
