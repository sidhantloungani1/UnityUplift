import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/screens/Dashboard.dart';
import 'package:student/screens/MainPage.dart';

class welcomescreen extends StatelessWidget {
  const welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/slide1.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var email = prefs.getString('email');
                  print(email);
                  if (email == null) {
                    Get.to(MainPage());
                  } else {
                    Get.to(DashboardScreen());
                  }
                },
                child: const CircleAvatar(
                  backgroundColor: Color(0xFF4350AF),
                  radius: 30.0,
                  child: Icon(Icons.arrow_forward,
                      size: 30.0, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Welcome!',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Student Portal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Unlocking Potential Through Education.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4350AF),
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
