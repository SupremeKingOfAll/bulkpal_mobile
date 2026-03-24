import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:bulkpal_mobile/features/meals/view_models/meal_model_view.dart';
import 'package:bulkpal_mobile/features/meals/widgets/elevated_meal_categories.dart';
import 'package:bulkpal_mobile/features/meals/widgets/meal_cards.dart';
import 'package:bulkpal_mobile/features/meals/widgets/title_meal_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final mView = context.watch<MealModelView>();

    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 20),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(mView.mList.length, (index) {
                  final CardItem = mView.mList[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TitleMealCards(
                      title: CardItem.cardTitle,
                      value: CardItem.value,
                      progressValue: CardItem.progressValue,
                      progressColour: CardItem.progressColour,
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(mView.Categories.length, (index) {
                return ElevatedMealCategories(
                  text: mView.Categories[index],
                  isActive: selectedIndex == index,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    customText: "Todays Meals",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  Icon(
                    Icons.calendar_today,
                    color: AppColours.textColour.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                    SizedBox(height: 20),
                    MealCards(
                      myIcon: Icons.no_food,
                      colour: Colors.blue,
                      title: "Steak & Asparagus",
                      subTitle: "Lunch • 12:45 AM",
                      calories: 650,
                    ),
                    SizedBox(height: 20),
                    MealCards(
                      myIcon: Icons.food_bank,
                      title: "Chicken Breast & Quinoa",
                      subTitle: "Lunch • 01:15 PM",
                      colour: Colors.purple,
                      calories: 820,
                    ),
                    SizedBox(height: 20),
                    MealCards(
                      myIcon: Icons.fastfood_outlined,
                      colour: Colors.green,
                      title: "Protien Oats + Whey",
                      subTitle: "Breakfast • 08:30 AM",
                      calories: 650,
                    ),
                    SizedBox(height: 20),
                    MealCards(
                      myIcon: Icons.emoji_food_beverage,
                      title: "Chicken Breast & Quinoa",
                      subTitle: "Lunch • 01:15 PM",
                      colour: Colors.red,
                      calories: 820,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/**/
