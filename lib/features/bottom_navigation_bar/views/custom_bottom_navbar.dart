import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({
    required this.currentPage,
    required this.OnDestinationSelected,
    super.key,
  });

  final int currentPage;
  final Function(int) OnDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(color: AppColours.secondaryAccent),
        ),
      ),
      child: NavigationBar(
        selectedIndex: currentPage,
        onDestinationSelected: OnDestinationSelected,
        backgroundColor: AppColours.primaryColour,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          NavigationDestination(
            icon: CustomButton(
              ContainerWidth: 30,
              ContainerHeight: 30,
              MyIcon: Icons.home,
              IconSize: 15,
              isSelected: currentPage == 0,
            ),
            label: "Dashboard",
          ),
          NavigationDestination(
            icon: CustomButton(
              ContainerWidth: 30,
              ContainerHeight: 30,
              MyIcon: Icons.stacked_line_chart,
              IconSize: 15,
              isSelected: currentPage == 1,
            ),
            label: "Progress",
          ),
          NavigationDestination(
            icon: CustomButton(
              ContainerWidth: 30,
              ContainerHeight: 30,
              MyIcon: Icons.person,
              IconSize: 15,
              isSelected: currentPage == 2,
            ),
            label: "Profile",
          ),
          NavigationDestination(
            icon: CustomButton(
              ContainerWidth: 30,
              ContainerHeight: 30,
              MyIcon: Icons.settings,
              IconSize: 15,
              isSelected: currentPage == 3,
            ),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
