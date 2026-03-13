import 'package:bulkpal_mobile/features/dashboard/view_models/dashboard_view_model.dart';
import 'package:bulkpal_mobile/features/dashboard/widgets/stat_hero_card.dart';
import 'package:flutter/material.dart';
import 'package:bulkpal_mobile/features/bottom_navigation_bar/views/custom_bottom_navbar.dart';
import '../widgets/stat_card.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int CurrentPage = 0;

  void OnSelected(int index) {
    setState(() {
      CurrentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DashBoardViewModel>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            StatCardHeroCard(
              height: 300,
              width: 300,
              title: "Calories",
              icon: Icons.no_meals,
              value: "${vm.caloriesConsumed.toString()} /",
              valueSize: 20,
              titleSize: 20,
              subTitle: vm.calorieTarget.toString(),
              iconContainerHeight: 60,
              iconContainerWidth: 60,
              iconSize: 35,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                StatCard(
                  height: 150,
                  width: 180,
                  title: vm.streakDays.toString(),
                  titleSize: 25,
                  icon: Icons.animation,
                  valueSize: 30,
                  subTitle: "Day Streak",
                  subTitleSize: 17,
                  iconContainerHeight: 30,
                  iconContainerWidth: 30,
                  iconSize: 20,
                ),
                SizedBox(width: 10),
                StatCard(
                  height: 150,
                  width: 180,
                  title: vm.adherenceScore.toString(),
                  titleSize: 30,
                  icon: Icons.timeline,
                  subTitleSize: 17,
                  subTitle: "Adherence",
                  iconContainerHeight: 30,
                  iconContainerWidth: 30,
                  iconSize: 20,
                ),
              ],
            ),
            SizedBox(height: 16),

            StatCard(
              height: 300,
              width: 300,
              title: "${vm.surplusCalories} +",
              titleSize: 20,
              icon: Icons.emoji_food_beverage,
              iconContainerHeight: 30,
              iconContainerWidth: 30,
              iconSize: 20,
              subTitle: "Surplus",
              subTitleSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
