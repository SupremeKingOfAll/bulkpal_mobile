import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:bulkpal_mobile/features/settings/widgets/bottom_settings_card.dart';
import 'package:bulkpal_mobile/features/settings/widgets/settings_card.dart';
import 'package:bulkpal_mobile/features/settings/widgets/top_settings_card.dart';
import 'package:bulkpal_mobile/services/auth_service.dart';
import 'package:bulkpal_mobile/features/notifications/view_models/notifications_service.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthService Auth = AuthService();
  bool IsLoggingOut = false;

  Future<void> LogOut() async {
    if (IsLoggingOut) return;

    setState(() {
      IsLoggingOut = true;
    });

    try {
      await Auth.SignOut();
    } catch (Error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out: ${Error.toString()}')),
      );

      setState(() {
        IsLoggingOut = false;
      });
      return;
    }

    if (!mounted) return;

    setState(() {
      IsLoggingOut = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, top: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    customText: "Account",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    myColour: AppColours.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TopSettingsCard(
                myIcon: Icons.person,
                title: "Profile",
                subTitle: "Edit personal details",
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 30, right: 31),
                color: Colors.white.withOpacity(0.3),
              ),
              SettingsCard(
                myIcon: Icons.person,
                title: "Change Goal ",
                subTitle: "Currently: Bulking",
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 30, right: 31),
                color: Colors.white.withOpacity(0.3),
              ),
              BottomSettingsCard(
                myIcon: Icons.person,
                title: "Profile",
                subTitle: "Edit personal details",
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    customText: "Notifications",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    myColour: AppColours.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TopSettingsCard(
                myIcon: Icons.person,
                title: "Meal Reminders",
                subTitle: "Get alerts to log meals",
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 30, right: 31),
                color: Colors.white.withOpacity(0.3),
              ),
              SettingsCard(
                myIcon: Icons.person,
                title: "Streak reminders",
                subTitle: "Don't lose your progress",
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 30, right: 31),
                color: Colors.white.withOpacity(0.3),
              ),
              BottomSettingsCard(
                myIcon: Icons.person,
                title: "Weigh-in Reminders",
                subTitle: "Weekly weigh-in alerts",
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    customText: "Privacy & Data",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    myColour: AppColours.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TopSettingsCard(
                myIcon: Icons.phonelink_erase,
                title: "Manage Data Colletion",
                subTitle: "Customise your privacy",
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 30, right: 31),
                color: Colors.white.withOpacity(0.3),
              ),
              SettingsCard(
                myIcon: Icons.wifi_tethering_off_rounded,
                title: "Clear Local Data",
                subTitle: "Reset app storage",
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 30, right: 31),
                color: Colors.white.withOpacity(0.3),
              ),
              BottomSettingsCard(
                myIcon: Icons.wifi_tethering_off_sharp,
                title: "Privacy Policy",
                subTitle: "Terms and legal",
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await NotificationService.Instance.ShowInstantNotification();
                },
                child: const Text('Test Notification'),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    customText: "App",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    myColour: AppColours.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TopSettingsCard(
                myIcon: Icons.wind_power_rounded,
                title: "Units",
                subTitle: "Current: kg",
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 30, right: 31),
                color: Colors.white.withOpacity(0.3),
              ),
              BottomSettingsCard(
                myIcon: Icons.wifi_tethering_error_rounded_outlined,
                title: "About BulkPal",
                subTitle: "Version 0.0.1",
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    customText: "Session",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    myColour: AppColours.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 15, bottom: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton.icon(
                    onPressed: IsLoggingOut ? null : LogOut,
                    icon: IsLoggingOut
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.2,
                              color: AppColours.primaryColour,
                            ),
                          )
                        : const Icon(Icons.logout_rounded),
                    label: Text(
                      IsLoggingOut ? "Logging Out..." : "Log Out",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColours.errorColour,
                      foregroundColor: AppColours.textColour,
                      disabledBackgroundColor: AppColours.errorColour
                          .withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
