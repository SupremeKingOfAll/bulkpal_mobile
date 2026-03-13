import 'package:bulkpal_mobile/features/bottom_navigation_bar/views/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:bulkpal_mobile/features/Profile/widgets/profile_page.dart';
import 'package:bulkpal_mobile/features/dashboard/views/dashboard_view.dart';
import 'package:bulkpal_mobile/features/settings/views/settings_page.dart';
import 'package:bulkpal_mobile/features/progress/views/progress_page.dart';

class NavigationController extends StatefulWidget {
  const NavigationController({super.key});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int currentPage = 0;

  final List<Widget> Pages = [
    DashboardView(),
    ProgressPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  final List<String> Titles = ["Dashboard", "progress", "Profile", "Settings"];

  void OnDestinationSelected(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Titles[currentPage])),
      body: Pages[currentPage],
      bottomNavigationBar: CustomBottomNavbar(
        currentPage: currentPage,
        OnDestinationSelected: OnDestinationSelected,
      ),
    );
  }
}
