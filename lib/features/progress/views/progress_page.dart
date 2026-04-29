import 'dart:math';

import 'package:bulkpal_mobile/core/widgets/loading_screen.dart';
import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:bulkpal_mobile/core/widgets/section_title.dart';
import 'package:provider/provider.dart';
import 'package:bulkpal_mobile/features/dashboard/view_models/dashboard_view_model.dart';
import 'package:bulkpal_mobile/features/meals/view_models/meal_log_view_model.dart';
import 'package:bulkpal_mobile/features/progress/widgets/progress_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  List<String> _DayLabels() {
    return ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  }

  Widget _BuildChart(List<int> DailyCalories) {
    final double MaxValue = DailyCalories.isEmpty
        ? 1000
        : max(1000, DailyCalories.reduce(max).toDouble() + 500);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColours.cardColour,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColours.textColour.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "7-Day Calorie Trend",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColours.textColour,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Daily calories logged across the last 7 days",
            style: TextStyle(fontSize: 13, color: AppColours.textSecondary),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                maxY: MaxValue,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: MaxValue / 4,
                  getDrawingHorizontalLine: (Value) {
                    return FlLine(
                      color: AppColours.textColour.withOpacity(0.06),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      interval: MaxValue / 4,
                      getTitlesWidget: (Value, Meta) {
                        return Text(
                          Value.toInt().toString(),
                          style: TextStyle(
                            color: AppColours.textSecondary,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (Value, Meta) {
                        final int Index = Value.toInt();
                        final List<String> Labels = _DayLabels();

                        if (Index < 0 || Index >= Labels.length) {
                          return const SizedBox.shrink();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            Labels[Index],
                            style: TextStyle(
                              color: AppColours.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(
                  DailyCalories.length,
                  (Index) => BarChartGroupData(
                    x: Index,
                    barRods: [
                      BarChartRodData(
                        toY: DailyCalories[Index].toDouble(),
                        width: 18,
                        borderRadius: BorderRadius.circular(6),
                        color: AppColours.navActive,
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: MaxValue,
                          color: AppColours.textColour.withOpacity(0.05),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DashboardVm = context.watch<DashBoardViewModel>();
    final MealLogVm = context.watch<MealLogViewModel>();

    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: FutureBuilder<WeeklyProgressData>(
          future: MealLogVm.GetWeeklyProgressData(DashboardVm.calorieTarget),
          builder: (context, Snapshot) {
            if (Snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen(Message: 'Loading progress...');
            }

            if (Snapshot.hasError || !Snapshot.hasData) {
              return const Center(
                child: Text(
                  "Unable to load progress data.",
                  style: TextStyle(color: AppColours.textColour),
                ),
              );
            }

            final WeeklyProgressData Data = Snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: SectionTitle(title: "Weekly Progress"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: CustomText(
                      customText:
                          "This week: ${Data.WeeklyDifference >= 0 ? '+' : ''}${NumberFormat('#,###').format(Data.WeeklyDifference)} kcal difference.",
                      myColour: AppColours.navActive,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ProgressCard(
                          title: "Avg Calories",
                          subTitle: NumberFormat(
                            '#,###',
                          ).format(Data.WeeklyAverage),
                          colour: AppColours.navActive,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ProgressCard(
                          title: "Adherence",
                          subTitle: "${Data.AdherencePercentage}%",
                          colour: AppColours.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _BuildChart(Data.DailyCalories),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ProgressCard(
                          title: "Weekly Difference",
                          subTitle:
                              "${Data.WeeklyDifference >= 0 ? '+' : ''}${NumberFormat('#,###').format(Data.WeeklyDifference)}",
                          colour: AppColours.navActive,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ProgressCard(
                          title: "Weekly Total",
                          subTitle: NumberFormat(
                            '#,###',
                          ).format(Data.WeeklyTotal),
                          colour: AppColours.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
