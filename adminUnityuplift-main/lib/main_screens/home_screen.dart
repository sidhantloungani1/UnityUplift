import 'dart:async';
import 'package:empower_admin_portal/users/availablescholarship.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../authentication/login_screen.dart';
import '../users/approvestatus.dart';
import '../users/Donationstostudent.dart';
import '../users/all_blocked_users_screen.dart';
import '../users/all_ngos.dart';
import '../users/scholarshiprequest.dart';
import '../users/all_verified_users_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String timeText = " ";
  String dateText = " ";
  Widget currentWidget = const AllVerifiedUsersScreen();
  Color hoverColor = const Color.fromARGB(255, 27, 27, 27).withOpacity(0.2);
  Color sidebarBackgroundColor = const Color(0xFF4350AF);

  String formatCurrentLiveTime(DateTime time) {
    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentDate(DateTime date) {
    return DateFormat("dd MMMM yyyy").format(date);
  }

  getCurrentLiveTime() {
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentDate(timeNow);

    if (this.mounted) {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //time
    timeText = formatCurrentLiveTime(DateTime.now());
    //date
    dateText = formatCurrentDate(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentLiveTime();
    });
  }

  Widget sidebarMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      onEnter: (event) => setState(() {}),
      onExit: (event) => setState(() {}),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        onTap: onTap,
        tileColor: hoverColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: sidebarBackgroundColor,
              border: const Border(
                right: BorderSide(
                  color: Colors.white, // Change this to your desired color
                  width: 2, // Change this to your desired width
                ),
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // Logo
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset('images/logo.png', height: 100),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),

                    // Sidebar buttons
                    sidebarMenuItem(
                      icon: Icons.person_add_sharp,
                      title: 'Active Students',
                      onTap: () {
                        setState(() {
                          currentWidget = const AllVerifiedUsersScreen();
                        });
                      },
                    ),
                    const Divider(color: Colors.white),

                    sidebarMenuItem(
                      icon: Icons.block_flipped,
                      title: 'Block Users ',
                      onTap: () {
                        setState(() {
                          currentWidget = const AllBlockedUsersScreen();
                        });
                      },
                    ),
                    const Divider(color: Colors.white),

                    sidebarMenuItem(
                      icon: Icons.request_page,
                      title: 'Scholarship Requests',
                      onTap: () {
                        setState(() {
                          currentWidget = const AllVerifiedSellersScreen();
                        });
                      },
                    ),
                    const Divider(color: Colors.white),

                    sidebarMenuItem(
                      icon: Icons.approval,
                      title: 'Approve Scholarship',
                      onTap: () {
                        setState(() {
                          currentWidget = const Approvestatus();
                        });
                      },
                    ),
                    const Divider(color: Colors.white),

                    sidebarMenuItem(
                      icon: Icons.person_add_sharp,
                      title: 'NGOS',
                      onTap: () {
                        setState(() {
                          currentWidget = const Allngos();
                        });
                      },
                    ),
                    const Divider(color: Colors.white),

                    sidebarMenuItem(
                      icon: Icons.block_flipped,
                      title: 'Donations to students',
                      onTap: () {
                        setState(() {
                          currentWidget = const Donationstostudent();
                        });
                      },
                    ),
                    const Divider(color: Colors.white),
                    sidebarMenuItem(
                      icon: Icons.event_available,
                      title: 'Available scholarship',
                      onTap: () {
                        setState(() {
                          currentWidget = const Availablescholarship();
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '$timeText\n$dateText',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.white),
                      title: const Text('Logout',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: Container(
              color: Colors.white,
              child: currentWidget,
            ),
          ),
        ],
      ),
    );
  }
}
