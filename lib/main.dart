import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bulkpal_mobile/core/theme/app_theme.dart';
import 'package:bulkpal_mobile/features/dashboard/views/dashboard_view.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/dashboard_view_model.dart';
import 'package:bulkpal_mobile/features/dashboard/views/testing_dashboard.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashBoardViewModel()),
      ],
      child: BulkPalApp(),
    ),
  );
}

class BulkPalApp extends StatelessWidget {
  const BulkPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestingDashboard(), //DashboardView(),
      theme: AppTheme.darkTheme,
    );
  }
}
