import 'package:flutter/material.dart';
import 'package:unity_uplift/NGO/utils/app_colors.dart';
import 'package:unity_uplift/components/custom_btn.dart';
import 'package:unity_uplift/NGO/screens/auth/Login_Screen.dart';
import 'package:unity_uplift/NGO/screens/auth/Registeration.dart';

class Welcome extends StatelessWidget {
  const Welcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/image4.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 220,
                    ),
                    // Heading of login on the left
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Have a better sharing experience',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Create an Account Button
                    CustomBtn(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                      height: 60,
                      width: 400.0,
                      text: 'Create an Account',
                      textColor: Colors.white,
                      // color: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 20),
                    // Login Button
                    CustomBtn(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      height: 60,
                      width: 400.0,
                      text: 'Login',
                      textColor: Colors.white,
                      // color: Color(0xFF4350AF),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
