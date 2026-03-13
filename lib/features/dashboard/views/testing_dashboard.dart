import 'package:bulkpal_mobile/features/dashboard/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_icon.dart';
import 'package:bulkpal_mobile/core/widgets/custom_button.dart';
import 'package:bulkpal_mobile/core/widgets/section_title.dart';

class TestingDashboard extends StatefulWidget {
  const TestingDashboard({super.key});

  @override
  State<TestingDashboard> createState() => _TestingDashboardState();
}

class _TestingDashboardState extends State<TestingDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            CustomIcons(
              myIcon: Icons.people,
              containerHeight: 30,
              containerWidth: 30,
              iconSize: 10,
            ),
            SizedBox(height: 20),
            StatCard(
              height: 250,
              width: 300,
              title: "Calories burned",
              titleSize: 16,
              value: "20",
              valueSize: 10,
              subTitle: "Kcal",
              icon: Icons.people,
              subTitleSize: 10,
              iconContainerHeight: 30,
              iconContainerWidth: 30,
              iconSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
