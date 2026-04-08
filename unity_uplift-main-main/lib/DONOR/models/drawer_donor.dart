// import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_uplift/DONOR/models/donor_profile.dart';
import 'package:unity_uplift/DONOR/screens/donor_dashboard.dart';
import 'package:unity_uplift/NGO/screens/auth/change_password.dart';
import 'package:unity_uplift/NGO/screens/donor_list.dart';
import 'package:unity_uplift/NGO/screens/setting_page.dart';
import 'package:unity_uplift/NGO/utils/app_colors.dart';

import '../screens/auth/donor_login.dart';

class donor_Drawer extends StatefulWidget {
  const donor_Drawer({super.key});

  @override
  donor_DrawerState createState() => donor_DrawerState();
}

class donor_DrawerState extends State<donor_Drawer> {
  late String sellerImage;
  late String donorName;

  @override
  void initState() {
    loadData();

    // TODO: implement initState
    super.initState();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sellerImage = prefs.getString('sellerImage_donor')!;
      donorName = prefs.getString('name_donor')!;
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
                  donorName.toString(),
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
                  builder: (context) => DonorProfilePage(),
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
                  builder: (context) => DonorsScreen(),
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
                  builder: (context) => const donor_DrawerWidget(),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.chat),
          //   title: const Text('chat'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const ChatScreen(),
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('change password'),
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
              prefs.remove('email_Donor');
              Get.offAll(() => const Donor_Login());
            },
          ),
        ],
      ),
    );
  }
}
