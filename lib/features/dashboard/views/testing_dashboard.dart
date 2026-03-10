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
            CustomButton(text: "Start"),
            SizedBox(height: 20),
            CustomIcons(myIcon: Icons.people),
            SizedBox(height: 20),
            StatCard(
              height: 150,
              width: 150,
              title: "Card",
              value: "20",
              subTitle: "CardSub",
            ),
          ],
        ),
      ),
    );
  }
}
