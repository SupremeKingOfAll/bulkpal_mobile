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
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SectionTitle(title: "Calories"),
            SizedBox(height: 10),
            StatCard(
              height: 300,
              width: 300,
              title: "StatCardOne",
              icon: Icons.people,
              value: "20",
              subTitle: "subTitle",
            ),
          ],
        ),
      ),
    );
  }
}
