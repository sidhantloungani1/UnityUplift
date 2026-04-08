import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/screens/Dashboard.dart';
import 'package:student/screens/History.dart';
import 'package:student/screens/MainPage.dart';
import 'package:student/screens/Profile.dart';
import 'package:student/screens/Settings.dart';
import 'package:student/utils/app_colors.dart';

class studentDrawerWidget extends StatefulWidget {
  const studentDrawerWidget({super.key});

  @override
  studentDrawerWidgetState createState() => studentDrawerWidgetState();
}

class studentDrawerWidgetState extends State<studentDrawerWidget> {
  late String sellerImage;
  late String studentName;

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
      studentName = prefs.getString('studentName')!;
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
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    sellerImage,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  studentName.toString(),
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
                  builder: (context) => studentProfilePage(),
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
                  builder: (context) => ScholarshipHistoryPage(),
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
                  builder: (context) => DashboardScreen(),
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
              prefs.remove('email');
              Get.offAll(() => MainPage());
            },
          ),
        ],
      ),
    );
  }
}
