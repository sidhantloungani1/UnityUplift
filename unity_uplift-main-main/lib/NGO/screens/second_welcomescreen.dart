import 'package:flutter/material.dart';
import 'package:unity_uplift/NGO/screens/welcome_screen.dart';

class secondwelcomescreen extends StatelessWidget {
  const secondwelcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Half area with picture and curved styling
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/welcomesecond.png"),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(),
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
                    MaterialPageRoute(
                        builder: (context) => const welcomescreen()),
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: Color(0xFF4350AF),
                  radius: 30.0,
                  child: Icon(Icons.arrow_forward,
                      size: 30.0, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Welcome!',
                style: TextStyle(
                  color: Color(0xFF4350AF),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Explore the App',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Pellentesque nec diam nec urna accumsan lacinia.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4350AF),
                    fontSize: 12,
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
