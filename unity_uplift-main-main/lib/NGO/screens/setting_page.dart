import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:unity_uplift/NGO/models/profile.dart';

import '../../../components/custom_btn.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? selectedNotificationOption; // Change type to int?

  bool enableDarkMode = false;
  bool enableBiometricAuthentication = false;

  @override
  Widget build(BuildContext context) {
    final adaptiveTheme = AdaptiveTheme.of(context);
    return Scaffold(
      appBar: AppBar(
          // Remove the title from the app bar
          // title: Text('App Settings'),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const Text(
              'App Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Notification Settings Section
            _buildSection(
              title: 'Notification Settings',
              settings: [
                ListTile(
                  title: const Text('Receive notifications'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                        value: 0,
                        groupValue: selectedNotificationOption,
                        onChanged: (value) {
                          setState(() {
                            selectedNotificationOption = value;
                          });
                        },
                      ),
                      const Text('On'),
                      Radio(
                        value: 1,
                        groupValue: selectedNotificationOption,
                        onChanged: (value) {
                          setState(() {
                            selectedNotificationOption = value;
                          });
                        },
                      ),
                      const Text('Off'),
                    ],
                  ),
                ),
              ],
            ),

            // Divider
            const Divider(height: 20, color: Colors.grey),

            // Appearance Settings Section
            // _buildSection(
            //   title: 'Appearance Settings',
            //   settings: [
            ValueListenableBuilder(
                valueListenable: adaptiveTheme.modeChangeNotifier,
                builder: (context, AdaptiveThemeMode adaptiveThemeMode, child) {
                  print(" swith ${adaptiveThemeMode.isLight}");
                  return ListTile(
                    title: const Text('Dark Mode'),
                    trailing: Switch(
                      value: AdaptiveTheme.of(context).mode.isDark,
                      onChanged: (value) {
                        if (value) {
                          AdaptiveTheme.of(context).setDark();
                        } else {
                          AdaptiveTheme.of(context).setLight();
                        }
                      },
                    ),
                  );
                }),
            //   ],
            // ),

            // Divider
            const Divider(height: 20, color: Colors.grey),

            // Security Settings Section
            _buildSection(
              title: 'Security Settings',
              settings: [
                ListTile(
                  title: const Text('Enable Biometric Authentication'),
                  trailing: Switch(
                    value: enableBiometricAuthentication,
                    onChanged: (value) {
                      setState(() {
                        enableBiometricAuthentication = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Save Button
            CustomBtn(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NGOProfilePage(),
                  ),
                );
              },
              height: 50,
              width: 380.0,
              text: 'Save Setting',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> settings}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...settings,
      ],
    );
  }
}
