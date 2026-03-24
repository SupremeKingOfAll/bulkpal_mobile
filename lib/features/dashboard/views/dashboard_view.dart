import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/add_calories_card.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/dashboard_view_model.dart';
import 'package:bulkpal_mobile/features/dashboard/widgets/stat_hero_card.dart';
import 'package:bulkpal_mobile/features/meals/widgets/title_meal_cards.dart';
import 'package:bulkpal_mobile/features/meals/widgets/meal_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../widgets/stat_card.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int CurrentPage = 0;

  void OnSelected(int index) {
    setState(() {
      CurrentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DashBoardViewModel>();
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppColours.secondaryAccent,
                strokeAlign: 1,
              ),

              color: AppColours.cardColour.withOpacity(0.15),
            ),
            child: SvgPicture.asset(
              "assets/images/happy_girl.svg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 45),
          CustomText(
            customText: "Welcome Back, Amy",
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          SizedBox(height: 6),
          CustomText(customText: "Goal: Hypertrophy Phase", fontSize: 16),
          SizedBox(height: 45),
          StatCardHeroCard(
            height: 220,
            width: 400,
            title: "Calories",
            icon: Icons.no_meals,
            value: NumberFormat('#,###').format(vm.caloriesConsumed),
            valueSize: 50,
            titleSize: 20,
            subTitle: "/ ${vm.calorieTarget.toString()}",
            iconContainerHeight: 60,
            iconContainerWidth: 60,
            iconSize: 35,
          ),
          SizedBox(height: 20),
          SizedBox(height: 20),
          Row(
            children: [
              StatCard(
                height: 150,
                width: 168,
                title: vm.streakDays.toString(),
                titleSize: 25,
                icon: Icons.animation,
                valueSize: 30,
                subTitle: "Day Streak",
                subTitleSize: 17,
                iconContainerHeight: 50,
                iconContainerWidth: 50,
                iconSize: 25,
              ),
              SizedBox(width: 20),
              StatCard(
                height: 150,
                width: 180,
                title: vm.adherenceScore.toString(),
                titleSize: 30,
                icon: Icons.timeline,
                subTitleSize: 17,
                subTitle: "Adherence",
                iconContainerHeight: 50,
                iconContainerWidth: 50,
                iconSize: 25,
              ),
            ],
          ),
          SizedBox(height: 32),
          AddCaloriesCard(),
          SizedBox(height: 32),
          Row(
            children: [
              CustomText(
                customText: "Recent Meals",
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
              Spacer(),
              CustomText(
                customText: "View All",
                myColour: AppColours.navActive,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(height: 20),
          MealCards(
            myIcon: Icons.table_restaurant_outlined,
            colour: Colors.orange,
            title: "Protien Oats + Whey",
            subTitle: "Breakfast • 08:30 AM",
            calories: 650,
          ),
          SizedBox(height: 20),
          MealCards(
            myIcon: Icons.shopping_cart_outlined,
            title: "Chicken Breast & Quinoa",
            subTitle: "Lunch • 01:15 PM",
            colour: Colors.tealAccent,
            calories: 820,
          ),
        ],
      ),
    );
  }
}

/* StatCard(
            height: 300,
            width: 300,
            title: "${vm.RemainingCalories()} +",
            titleSize: 20,
            icon: Icons.emoji_food_beverage,
            iconContainerHeight: 60,
            iconContainerWidth: 60,
            iconSize: 35,
            subTitle: "Surplus",
            subTitleSize: 20,
          ),*/
