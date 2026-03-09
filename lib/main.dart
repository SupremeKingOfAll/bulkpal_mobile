import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bulkpal_mobile/features/dashboard/views/home_screen.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/dashboard_view_model.dart';

void main() {
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DashBoardViewModel()),
    ],
    child: BulkPalApp(),
  );
}

class BulkPalApp extends StatelessWidget {
  const BulkPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
