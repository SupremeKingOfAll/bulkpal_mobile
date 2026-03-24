import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:bulkpal_mobile/core/widgets/section_title.dart';
import 'package:bulkpal_mobile/features/meals/widgets/title_meal_cards.dart';
import 'package:flutter/material.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 19),
              child: SectionTitle(title: "Weekly Gains"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CustomText(customText: "This week: +1,250 kcal surplus."),
            ),
          ],
        ),
      ),
    );
  }
}
