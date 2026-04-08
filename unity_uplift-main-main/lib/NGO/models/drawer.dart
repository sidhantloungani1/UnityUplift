// import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_uplift/NGO/models/chat_Profile.dart';
import 'package:unity_uplift/NGO/models/profile.dart';
import 'package:unity_uplift/NGO/screens/auth/Login_Screen.dart';
import 'package:unity_uplift/NGO/screens/auth/change_password.dart';
import 'package:unity_uplift/NGO/screens/dashboard/dashboard_org.dart';
import 'package:unity_uplift/NGO/screens/history.dart';
import 'package:unity_uplift/NGO/screens/setting_page.dart';
import 'package:unity_uplift/NGO/utils/app_colors.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  DrawerWidgetState createState() => DrawerWidgetState();
}

class DrawerWidgetState extends State<DrawerWidget> {
  late String sellerImage;
  late String NGOName;

  @override
  void initState() {
    loadData();

    // TODO: implement initState
    super.initState();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sellerImage = prefs.getString('sellerImage')!;
      NGOName = prefs.getString('organizationName')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                /*CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile.jpeg'),
                ),*/
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    sellerImage,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  NGOName.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('View Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NGOProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => historypage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const dashboard_NGO(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.password_outlined),
            title: const Text('Change password'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email_NGO');
              Get.offAll(() => const LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
