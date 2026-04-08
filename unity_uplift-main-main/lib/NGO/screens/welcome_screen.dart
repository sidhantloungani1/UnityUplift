import 'package:flutter/material.dart';
import 'package:unity_uplift/dashboard.dart';

class welcomescreen extends StatelessWidget {
  const welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Half area with picture and curved styling
          Expanded(
            flex: 2,
            child: Container(
              height: 300.0, // Set the desired height here
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/welcomesecond.png"),
                  fit: BoxFit.fitHeight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(60),
                ),
              ),
            ),
          ),
          // Half area with text, bold text, and navigation dots
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to the next screen when the avatar is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const dashboard()),
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: Color(0xFF4350AF),
                  radius: 40.0,
                  child: Icon(Icons.arrow_forward,
                      size: 40.0, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'welcome to unityuplift.',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Empowering Unity: Elevate Your Experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4350AF),
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
