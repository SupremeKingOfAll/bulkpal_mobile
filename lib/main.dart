import 'package:bulkpal_mobile/core/theme/app_theme.dart';
import 'package:bulkpal_mobile/features/authentication/auth_wrapper.dart';
import 'package:bulkpal_mobile/features/bottom_navigation_bar/view_models/navigation_controller.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/dashboard_view_model.dart';
import 'package:bulkpal_mobile/features/meals/view_models/meal_log_view_model.dart';
import 'package:bulkpal_mobile/features/meals/view_models/meal_view_model.dart';
import 'package:bulkpal_mobile/features/notifications/view_models/notifications_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.Instance.Initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashBoardViewModel()),
        ChangeNotifierProvider(create: (context) => MealViewModel()),
        ChangeNotifierProvider(create: (context) => MealLogViewModel()),
      ],
      child: const BulkPalApp(),
    ),
  );
}

class BulkPalApp extends StatelessWidget {
  const BulkPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
      theme: AppTheme.darkTheme,
    );
  }
}
