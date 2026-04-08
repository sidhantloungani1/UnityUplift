import 'package:flutter/material.dart';
import 'package:unity_uplift/DONOR/screens/auth/donor_login.dart';
import 'package:unity_uplift/DONOR/screens/auth/donor_registration.dart';
import 'package:unity_uplift/NGO/utils/app_colors.dart';
import 'package:unity_uplift/components/custom_btn.dart';

class Donor_welcome extends StatelessWidget {
  const Donor_welcome({
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
                  image: AssetImage('assets/images/image5.png'),
                  fit: BoxFit.contain,
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
                      height: 150,
                    ),
                    // Heading of login on the left
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'welcome',
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
                      alignment: Alignment.bottomCenter,
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
                            builder: (context) =>
                                const Donor_RegistrationScreen(),
                          ),
                        );
                      },
                      height: 60,
                      width: 400.0,
                      text: 'Create an Account',
                      textColor: Colors.white,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 20),
                    // Login Button
                    CustomBtn(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Donor_Login(),
                          ),
                        );
                      },
                      height: 60,
                      width: 400.0,
                      text: 'Login',
                      textColor: Colors.white,
                      color: AppColors.primaryColor,
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
