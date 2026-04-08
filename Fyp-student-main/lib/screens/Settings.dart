import 'package:flutter/material.dart';
import 'package:student/screens/Profile.dart';

import '../../components/custom_btn.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? selectedNotificationOption;

  bool enableDarkMode = false;
  bool enableBiometricAuthentication = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('App Settings'),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // Notification Settings Section
            _buildSection(
              title: 'Notification Settings',
              settings: [
                ListTile(
                  title: Text('Receive notifications'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                        value: 0,
                        groupValue: selectedNotificationOption,
                        onChanged: (value) {
                          setState(() {
                            selectedNotificationOption = value as int?;
                          });
                        },
                      ),
                      const Text('On'),
                      Radio(
                        value: 1,
                        groupValue: selectedNotificationOption,
                        onChanged: (value) {
                          setState(() {
                            selectedNotificationOption = value as int?;
                          });
                        },
                      ),
                      const Text('Off'),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 20, color: Colors.grey),

            // Appearance Settings Section
            _buildSection(
              title: 'Appearance Settings',
              settings: [
                ListTile(
                  title: Text('Dark Mode'),
                  trailing: Switch(
                    value: enableDarkMode,
                    onChanged: (value) {
                      setState(() {
                        enableDarkMode = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            // Divider
            Divider(height: 20, color: Colors.grey),

            // Security Settings Section
            _buildSection(
              title: 'Security Settings',
              settings: [
                ListTile(
                  title: Text('Enable Biometric Authentication'),
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

            CustomBtn(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => studentProfilePage(),
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
