import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/features/bottom_navigation_bar/views/custom_bottom_navbar.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bulkpal_mobile/features/Profile/widgets/profile_page.dart';
import 'package:bulkpal_mobile/features/dashboard/views/dashboard_view.dart';
import 'package:bulkpal_mobile/features/settings/views/settings_page.dart';
import 'package:bulkpal_mobile/features/progress/views/progress_page.dart';
import 'package:bulkpal_mobile/features/meals/views/meals_page.dart';

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
    MealPage(),
    SettingsPage(),
  ];

  final List<String> Titles = ["Dashboard", "progress", "Meals", "Settings"];

  void OnDestinationSelected(int index) {
    setState(() {
      currentPage = index;
    });
  }

  Widget _BuildAppBarTitle() {
    if (currentPage == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Meals",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Container(
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColours.cardColour,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Icon(
                    Icons.search,
                    color: AppColours.textColour.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                "Today: ",
                style: TextStyle(fontSize: 14, color: AppColours.textSecondary),
              ),

              Text(
                NumberFormat(
                  "#,###",
                ).format(context.watch<DashBoardViewModel>().caloriesConsumed),
                style: TextStyle(color: AppColours.navActive, fontSize: 14),
              ),

              Text(
                " • 4 meals",
                style: TextStyle(fontSize: 14, color: AppColours.textSecondary),
              ),
            ],
          ),
        ],
      );
    }
    //
    return Text(Titles[currentPage]);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DashBoardViewModel>();
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: _BuildAppBarTitle()),
      body: Pages[currentPage],
      bottomNavigationBar: CustomBottomNavbar(
        currentPage: currentPage,
        OnDestinationSelected: OnDestinationSelected,
      ),
    );
  }
}
