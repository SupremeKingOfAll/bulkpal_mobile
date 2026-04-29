import 'dart:async';
import 'package:bulkpal_mobile/core/widgets/loading_screen.dart';
import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/add_calories_card.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/dashboard_view_model.dart';
import 'package:bulkpal_mobile/features/dashboard/widgets/stat_hero_card.dart';
import 'package:bulkpal_mobile/features/meals/view_models/meal_log_view_model.dart';
import 'package:bulkpal_mobile/features/meals/views/meals_page.dart';
import 'package:bulkpal_mobile/features/meals/widgets/meal_cards.dart';
import 'package:bulkpal_mobile/models/logged_meal_model.dart';
import 'package:bulkpal_mobile/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/stat_card.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String UserName = 'User';
  StreamSubscription<User?>? _userSubscription;
  late Future<void> _DashboardFuture;

  @override
  void initState() {
    super.initState();

    _DashboardFuture = LoadDashboardData();

    _userSubscription = AuthService().GetAuthStateChanges().listen((_) {
      LoadUserName();
    });
  }

  Future<void> LoadDashboardData() async {
    final MealLogViewModel MealLogVm = context.read<MealLogViewModel>();

    await LoadUserName();
    await MealLogVm.LoadMealsForSelectedDate();
  }

  Future<void> LoadUserName() async {
    final AuthService Auth = AuthService();

    await Auth.GetCurrentUser()?.reload();
    final User? CurrentUser = Auth.GetCurrentUser();

    if (!mounted) return;

    final String DisplayName =
        (CurrentUser?.displayName != null &&
            CurrentUser!.displayName!.trim().isNotEmpty)
        ? CurrentUser.displayName!.trim()
        : 'User';

    setState(() {
      UserName = DisplayName;
    });

    final bool DidJustRegister = Auth.ConsumeDidJustRegister();

    if (DidJustRegister && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created successfully, welcome $UserName'),
        ),
      );
    }
  }

  String FormatTime(BuildContext context, DateTime Date) {
    return TimeOfDay.fromDateTime(Date).format(context);
  }

  Widget BuildRecentMealsSection(MealLogViewModel MealLogVm) {
    final List<LoggedMealModel> RecentMeals = MealLogVm.LoggedMeals.take(
      2,
    ).toList();

    if (MealLogVm.IsLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColours.navActive),
      );
    }

    if (MealLogVm.ErrorMessage.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          MealLogVm.ErrorMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColours.textColour),
        ),
      );
    }

    if (RecentMeals.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 12),
        child: Text(
          'No meals added yet',
          style: TextStyle(color: AppColours.textSecondary),
        ),
      );
    }

    return Column(
      children: List.generate(RecentMeals.length, (Index) {
        final LoggedMealModel Meal = RecentMeals[Index];

        return Padding(
          padding: EdgeInsets.only(
            bottom: Index == RecentMeals.length - 1 ? 0 : 20,
          ),
          child: BuildRecentMealCard(
            context: context,
            Meal: Meal,
            Index: Index,
          ),
        );
      }),
    );
  }

  Widget BuildRecentMealCard({
    required BuildContext context,
    required LoggedMealModel Meal,
    required int Index,
  }) {
    final List<Color> CardColours = [
      Colors.orange,
      Colors.tealAccent,
      AppColours.accentColour,
      AppColours.secondaryAccent,
      AppColours.successColour,
    ];

    final List<IconData> CardIcons = [
      Icons.table_restaurant_outlined,
      Icons.shopping_cart_outlined,
      Icons.no_food,
      Icons.food_bank,
      Icons.fastfood_outlined,
    ];

    return MealCards(
      MyIcon: CardIcons[Index % CardIcons.length],
      Colour: CardColours[Index % CardColours.length],
      Title: Meal.Name,
      SubTitle: '${Meal.MealType} • ${FormatTime(context, Meal.Date)}',
      TrailingValue: Meal.Calories.toString(),
      TrailingLabel: 'KCAL',
    );
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DashBoardViewModel DashboardVm = context.watch<DashBoardViewModel>();
    final MealLogViewModel MealLogVm = context.watch<MealLogViewModel>();

    final int DynamicAdherenceScore = DashboardVm.calorieTarget <= 0
        ? 0
        : ((MealLogVm.TotalCalories / DashboardVm.calorieTarget) * 100)
              .clamp(0, 100)
              .round();

    final int DynamicStreakDays = MealLogVm.TotalCalories > 0 ? 1 : 0;

    return FutureBuilder<void>(
      future: _DashboardFuture,
      builder: (context, Snapshot) {
        if (Snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen(Message: 'Loading dashboard...');
        }

        if (Snapshot.hasError) {
          return const Center(
            child: Text(
              'Unable to load dashboard.',
              style: TextStyle(color: AppColours.textColour),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
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
                  'assets/images/bulkpal_image.svg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 45),
              CustomText(
                customText: 'Welcome Back, $UserName',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              const SizedBox(height: 6),
              const CustomText(
                customText: 'Goal: Hypertrophy Phase',
                fontSize: 16,
              ),
              const SizedBox(height: 45),
              StatCardHeroCard(
                height: 220,
                width: double.infinity,
                title: 'Calories Today',
                icon: Icons.no_meals,
                value: NumberFormat('#,###').format(MealLogVm.TotalCalories),
                valueSize: 50,
                titleSize: 20,
                subTitle: '/ ${DashboardVm.calorieTarget} kcal',
                subTitleSize: 18,
                iconContainerHeight: 60,
                iconContainerWidth: 60,
                iconSize: 35,
                totalCalories: MealLogVm.TotalCalories,
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  StatCard(
                    height: 150,
                    width: 156,
                    title: DynamicStreakDays.toString(),
                    titleSize: 25,
                    icon: Icons.animation,
                    valueSize: 30,
                    subTitle: 'Day Streak',
                    subTitleSize: 17,
                    iconContainerHeight: 50,
                    iconContainerWidth: 50,
                    iconSize: 25,
                  ),
                  Spacer(),
                  StatCard(
                    height: 150,
                    width: 156,
                    title: DynamicAdherenceScore.toString(),
                    titleSize: 30,
                    icon: Icons.timeline,
                    subTitleSize: 17,
                    subTitle: 'Adherence',
                    iconContainerHeight: 50,
                    iconContainerWidth: 50,
                    iconSize: 25,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              AddCaloriesCard(totalCalories: MealLogVm.TotalCalories),
              const SizedBox(height: 32),
              Row(
                children: [
                  CustomText(
                    customText: 'Recent Meals',
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MealPage(),
                        ),
                      );
                    },
                    child: CustomText(
                      customText: 'View All',
                      myColour: AppColours.navActive,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BuildRecentMealsSection(MealLogVm),
            ],
          ),
        );
      },
    );
  }
}
