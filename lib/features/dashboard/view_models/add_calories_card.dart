import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AddCaloriesCard extends StatelessWidget {
  const AddCaloriesCard({required this.totalCalories, super.key});

  final int totalCalories;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DashBoardViewModel>();

    return SafeArea(
      child: Container(
        width: 365,
        height: 125,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColours.navActive.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(40),
          gradient: const LinearGradient(
            colors: [AppColours.surfaceHighlight, AppColours.cardColour],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Calories Remaining",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColours.textColour.withOpacity(0.7),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  customText: "${vm.RemainingCalories(totalCalories)}",
                  fontSize: 39,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "kcal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColours.textColour.withOpacity(0.7),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.white24.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 43,
                        color: AppColours.navActive,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
