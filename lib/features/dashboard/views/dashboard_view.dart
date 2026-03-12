import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bulkpal_mobile/core/widgets/section_title.dart';
import '../widgets/stat_card.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Dashboard")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            StatCard(
              height: 300,
              width: 300,
              title: "Calories",
              titleSize: 38,
              icon: Icons.no_meals,
              value: "1250",
              valueSize: 30,
              subTitle: "/ 3000 Kcal",
              subTitleSize: 20,
              iconContainerHeight: 70,
              iconContainerWidth: 70,
              iconSize: 28,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                StatCard(
                  height: 150,
                  width: 180,
                  title: "7",
                  titleSize: 13,
                  icon: Icons.animation,
                  valueSize: 10,
                  subTitle: "Day Streak",
                  subTitleSize: 10,
                  iconContainerHeight: 30,
                  iconContainerWidth: 30,
                  iconSize: 20,
                ),
                SizedBox(width: 10),
                StatCard(
                  height: 150,
                  width: 180,
                  title: "82%",
                  titleSize: 13,
                  icon: Icons.timeline,
                  valueSize: 10,
                  subTitleSize: 10,
                  subTitle: "Adherence",
                  iconContainerHeight: 30,
                  iconContainerWidth: 30,
                  iconSize: 20,
                ),
              ],
            ),
            SizedBox(height: 16),

            StatCard(
              height: 200,
              width: 200,
              title: "+320",
              titleSize: 13,
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
