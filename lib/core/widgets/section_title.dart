import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title, super.key});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColours.textColour,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
