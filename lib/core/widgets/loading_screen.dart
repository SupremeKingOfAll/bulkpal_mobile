import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({this.Message = 'Loading...', super.key});

  final String Message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        decoration: BoxDecoration(
          color: AppColours.cardColour,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColours.navActive.withOpacity(0.25),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColours.navActive),
            const SizedBox(height: 18),
            Text(
              Message,
              style: const TextStyle(
                color: AppColours.textColour,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
