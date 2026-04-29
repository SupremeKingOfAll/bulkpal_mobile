import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/features/bottom_navigation_bar/views/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bulkpal_mobile/features/dashboard/views/dashboard_view.dart';
import 'package:bulkpal_mobile/features/settings/views/settings_page.dart';
import 'package:bulkpal_mobile/features/progress/views/progress_page.dart';
import 'package:bulkpal_mobile/features/meals/views/meals_page.dart';
import 'package:bulkpal_mobile/features/meals/view_models/meal_log_view_model.dart';
import 'package:bulkpal_mobile/services/auth_service.dart';

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

  final List<String> Titles = ["Dashboard", "Progress", "Meals", "Settings"];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bool DidJustRegister = AuthService().ConsumeDidJustRegister();

      if (DidJustRegister && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully')),
        );
      }
    });
  }

  void OnDestinationSelected(int index) {
    setState(() {
      currentPage = index;
    });
  }

  Widget _BuildAppBarTitle() {
    if (currentPage == 2) {
      final MealLogVm = context.watch<MealLogViewModel>();

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
              const Spacer(),
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
              const Text(
                "Today: ",
                style: TextStyle(fontSize: 14, color: AppColours.textSecondary),
              ),
              Text(
                NumberFormat("#,###").format(MealLogVm.TotalCalories),
                style: const TextStyle(
                  color: AppColours.navActive,
                  fontSize: 14,
                ),
              ),
              const Text(
                " kcal",
                style: TextStyle(fontSize: 14, color: AppColours.textSecondary),
              ),
              Text(
                " • ${MealLogVm.LoggedMeals.length} meals",
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColours.textSecondary,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Text(Titles[currentPage]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: currentPage == 2 ? 80 : 56,
        title: _BuildAppBarTitle(),
      ),
      body: Pages[currentPage],
      bottomNavigationBar: CustomBottomNavbar(
        currentPage: currentPage,
        OnDestinationSelected: OnDestinationSelected,
      ),
    );
  }
}
