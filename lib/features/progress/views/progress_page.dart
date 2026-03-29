import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:bulkpal_mobile/core/widgets/section_title.dart';
import 'package:bulkpal_mobile/features/meals/widgets/title_meal_cards.dart';
import 'package:provider/provider.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/dashboard_view_model.dart';
import 'package:bulkpal_mobile/features/progress/widgets/hero_progress_card.dart';
import 'package:bulkpal_mobile/features/progress/widgets/progress_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    final mView = context.watch<DashBoardViewModel>();
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: SectionTitle(title: "Weekly Gains"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: CustomText(
                  customText:
                      "This week: ${NumberFormat('#,###').format(mView.caloriesConsumed)} kcal surplus.",
                  myColour: AppColours.navActive,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 20),
              HeroProgressCard(
                myIcon: Icons.emoji_food_beverage,
                colour: AppColours.navActive,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ProgressCard(
                    title: "Weekly Surplus",
                    subTitle: "+1,250",
                    colour: AppColours.navActive,
                  ),
                  Spacer(),
                  ProgressCard(
                    title: "Adherence",
                    subTitle: "82%",
                    colour: AppColours.textSecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
