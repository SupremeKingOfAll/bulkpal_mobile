import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:bulkpal_mobile/core/widgets/loading_screen.dart';
import 'package:bulkpal_mobile/features/meals/view_models/meal_log_view_model.dart';
import 'package:bulkpal_mobile/features/meals/widgets/elevated_meal_categories.dart';
import 'package:bulkpal_mobile/features/meals/widgets/meal_cards.dart';
import 'package:bulkpal_mobile/features/meals/widgets/title_meal_cards.dart';
import 'package:bulkpal_mobile/models/logged_meal_model.dart';
import 'package:bulkpal_mobile/models/meal_card_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  int SelectedIndex = 0;
  late Future<void> _MealsFuture;

  final List<String> MealTypeFilters = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];

  @override
  void initState() {
    super.initState();
    _MealsFuture = _LoadMealsWithMinimumDelay();
  }

  Future<void> _LoadMealsWithMinimumDelay() async {
    final MealLogViewModel MealLogProvider = context.read<MealLogViewModel>();

    await Future.wait([
      MealLogProvider.LoadMealsForSelectedDate(),
      Future.delayed(const Duration(milliseconds: 600)),
    ]);
  }

  List<LoggedMealModel> _GetFilteredMeals(List<LoggedMealModel> Meals) {
    final String SelectedFilter = MealTypeFilters[SelectedIndex];

    if (SelectedFilter == 'All') {
      return Meals;
    }

    return Meals.where((Meal) => Meal.MealType == SelectedFilter).toList();
  }

  double _GetProgress(int Current, int Target) {
    if (Target <= 0) {
      return 0;
    }

    final double Progress = Current / Target;

    if (Progress < 0) {
      return 0;
    }

    if (Progress > 1) {
      return 1;
    }

    return Progress;
  }

  String _FormatTime(BuildContext context, DateTime Date) {
    return TimeOfDay.fromDateTime(Date).format(context);
  }

  Future<void> _PickDate() async {
    final MealLogProvider = context.read<MealLogViewModel>();

    final DateTime? PickedDate = await showDatePicker(
      context: context,
      initialDate: MealLogProvider.SelectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (PickedDate != null) {
      MealLogProvider.SetSelectedDate(PickedDate);
    }
  }

  Future<void> _ShowMealFormSheet({LoggedMealModel? ExistingMeal}) async {
    final TextEditingController NameController = TextEditingController(
      text: ExistingMeal?.Name ?? '',
    );
    final TextEditingController CaloriesController = TextEditingController(
      text: ExistingMeal?.Calories.toString() ?? '',
    );
    final TextEditingController ProteinController = TextEditingController(
      text: ExistingMeal?.Protein.toString() ?? '',
    );
    final TextEditingController CarbsController = TextEditingController(
      text: ExistingMeal?.Carbs.toString() ?? '',
    );
    final TextEditingController FatsController = TextEditingController(
      text: ExistingMeal?.Fats.toString() ?? '',
    );
    final TextEditingController ServingsController = TextEditingController(
      text: ExistingMeal?.Servings.toString() ?? '1',
    );

    String SelectedMealType = ExistingMeal?.MealType ?? 'Breakfast';

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColours.cardColour,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BottomSheetContext) {
        return StatefulBuilder(
          builder: (context, SetModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      customText: ExistingMeal == null
                          ? 'Add Meal'
                          : 'Edit Meal',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 20),
                    _BuildTextField(
                      Controller: NameController,
                      LabelText: 'Meal Name',
                      KeyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      value: SelectedMealType,
                      dropdownColor: AppColours.cardColour,
                      decoration: InputDecoration(
                        labelText: 'Meal Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Breakfast',
                          child: Text('Breakfast'),
                        ),
                        DropdownMenuItem(value: 'Lunch', child: Text('Lunch')),
                        DropdownMenuItem(
                          value: 'Dinner',
                          child: Text('Dinner'),
                        ),
                        DropdownMenuItem(
                          value: 'Snacks',
                          child: Text('Snacks'),
                        ),
                      ],
                      onChanged: (Value) {
                        if (Value != null) {
                          SetModalState(() {
                            SelectedMealType = Value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _BuildTextField(
                            Controller: CaloriesController,
                            LabelText: 'Calories',
                            KeyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _BuildTextField(
                            Controller: ServingsController,
                            LabelText: 'Servings',
                            KeyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _BuildTextField(
                            Controller: ProteinController,
                            LabelText: 'Protein',
                            KeyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _BuildTextField(
                            Controller: CarbsController,
                            LabelText: 'Carbs',
                            KeyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _BuildTextField(
                            Controller: FatsController,
                            LabelText: 'Fats',
                            KeyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final String Name = NameController.text.trim();

                          if (Name.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Meal name is required.'),
                              ),
                            );
                            return;
                          }

                          final int Calories =
                              int.tryParse(CaloriesController.text.trim()) ?? 0;
                          final int Protein =
                              int.tryParse(ProteinController.text.trim()) ?? 0;
                          final int Carbs =
                              int.tryParse(CarbsController.text.trim()) ?? 0;
                          final int Fats =
                              int.tryParse(FatsController.text.trim()) ?? 0;
                          final double Servings =
                              double.tryParse(ServingsController.text.trim()) ??
                              1;

                          final MealLogProvider = context
                              .read<MealLogViewModel>();

                          if (ExistingMeal == null) {
                            await MealLogProvider.AddMealLog(
                              Name: Name,
                              MealType: SelectedMealType,
                              Calories: Calories,
                              Protein: Protein,
                              Carbs: Carbs,
                              Fats: Fats,
                              Servings: Servings,
                              Date: MealLogProvider.SelectedDate,
                              Source: 'manual',
                            );
                          } else {
                            await MealLogProvider.UpdateMealLog(
                              ExistingMeal.CopyWith(
                                Name: Name,
                                MealType: SelectedMealType,
                                Calories: Calories,
                                Protein: Protein,
                                Carbs: Carbs,
                                Fats: Fats,
                                Servings: Servings,
                              ),
                            );
                          }

                          if (!mounted) return;
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            ExistingMeal == null ? 'Add Meal' : 'Save Changes',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _BuildTextField({
    required TextEditingController Controller,
    required String LabelText,
    required TextInputType KeyboardType,
  }) {
    return TextField(
      controller: Controller,
      keyboardType: KeyboardType,
      decoration: InputDecoration(
        labelText: LabelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _MealsFuture,
      builder: (context, Snapshot) {
        if (Snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen(Message: 'Loading meals...');
        }

        if (Snapshot.hasError) {
          return const Center(
            child: Text(
              'Unable to load meals.',
              style: TextStyle(color: AppColours.textColour),
            ),
          );
        }

        return _BuildMealPageContent(context);
      },
    );
  }

  Widget _BuildMealPageContent(BuildContext context) {
    final MealLogViewModel MealLogProvider = context.watch<MealLogViewModel>();

    final List<LoggedMealModel> LoggedMeals = _GetFilteredMeals(
      MealLogProvider.LoggedMeals,
    );

    final List<MealCardModel> MealSummaryCards = [
      MealCardModel(
        cardTitle: 'Calories',
        value: MealLogProvider.TotalCalories.toDouble(),
        progressValue: _GetProgress(MealLogProvider.TotalCalories, 3000),
        progressColour: AppColours.accentColour,
      ),
      MealCardModel(
        cardTitle: 'Protein',
        value: MealLogProvider.TotalProtein.toDouble(),
        progressValue: _GetProgress(MealLogProvider.TotalProtein, 180),
        progressColour: AppColours.secondaryAccent,
      ),
      MealCardModel(
        cardTitle: 'Carbs',
        value: MealLogProvider.TotalCarbs.toDouble(),
        progressValue: _GetProgress(MealLogProvider.TotalCarbs, 400),
        progressColour: AppColours.successColour,
      ),
      MealCardModel(
        cardTitle: 'Fats',
        value: MealLogProvider.TotalFats.toDouble(),
        progressValue: _GetProgress(MealLogProvider.TotalFats, 80),
        progressColour: AppColours.surfaceHighlight,
      ),
    ];

    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(MealSummaryCards.length, (Index) {
                  final MealCardModel CardItem = MealSummaryCards[Index];

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
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(MealTypeFilters.length, (Index) {
                  return ElevatedMealCategories(
                    text: MealTypeFilters[Index],
                    isActive: SelectedIndex == Index,
                    onTap: () {
                      setState(() {
                        SelectedIndex = Index;
                      });
                    },
                  );
                }),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  const CustomText(
                    customText: "Todays Meals",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _PickDate,
                    child: Icon(
                      Icons.calendar_today,
                      color: AppColours.textColour.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: [
                  _BuildMealList(
                    MealLogProvider: MealLogProvider,
                    LoggedMeals: LoggedMeals,
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: AppColours.navActive,
                            offset: const Offset(0, 2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: FittedBox(
                        child: FloatingActionButton(
                          shape: const CircleBorder(),
                          backgroundColor: AppColours.navActive,
                          onPressed: () {
                            _ShowMealFormSheet();
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _BuildMealList({
    required MealLogViewModel MealLogProvider,
    required List<LoggedMealModel> LoggedMeals,
  }) {
    if (MealLogProvider.IsLoading) {
      return const LoadingScreen(Message: 'Loading meals...');
    }

    if (MealLogProvider.ErrorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            MealLogProvider.ErrorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColours.textColour),
          ),
        ),
      );
    }

    if (LoggedMeals.isEmpty) {
      return const Center(
        child: Text(
          'No meals added yet',
          style: TextStyle(color: AppColours.textSecondary),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
      itemCount: LoggedMeals.length,
      separatorBuilder: (context, Index) {
        return const SizedBox(height: 20);
      },
      itemBuilder: (context, Index) {
        final LoggedMealModel Meal = LoggedMeals[Index];

        final List<Color> CardColours = [
          AppColours.accentColour,
          AppColours.secondaryAccent,
          AppColours.successColour,
          AppColours.surfaceHighlight,
          AppColours.navActive,
          AppColours.textSecondary,
        ];

        final List<IconData> CardIcons = [
          Icons.table_restaurant_outlined,
          Icons.shopping_cart_outlined,
          Icons.no_food,
          Icons.food_bank,
          Icons.fastfood_outlined,
          Icons.emoji_food_beverage,
        ];

        return Dismissible(
          key: ValueKey(Meal.Id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (Direction) async {
            await context.read<MealLogViewModel>().DeleteMealLog(Meal.Id);

            if (!context.mounted) {
              return false;
            }

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Meal deleted.')));

            return false;
          },
          child: GestureDetector(
            onTap: () {
              _ShowMealFormSheet(ExistingMeal: Meal);
            },
            child: MealCards(
              MyIcon: CardIcons[Index % CardIcons.length],
              Colour: CardColours[Index % CardColours.length],
              Title: Meal.Name,
              SubTitle: '${Meal.MealType} • ${_FormatTime(context, Meal.Date)}',
              TrailingValue: Meal.Calories.toString(),
              TrailingLabel: 'KCAL',
            ),
          ),
        );
      },
    );
  }
}
