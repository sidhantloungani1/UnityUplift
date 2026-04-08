import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/screens/Dashboard.dart';
import 'package:student/screens/auth/Registration.dart';
import 'package:student/utils/app_colors.dart';

import '../../components/custom_btn.dart';
import '../../components/custom_text.dart';
import '../../utils/app-constant.dart';
import '../Welcome.dart';
import 'auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      UserCredential? userCredential = await AuthController.instance
          .login(context, _emailController.text, _passwordController.text);
      if (userCredential != null) {
        if (userCredential.user!.emailVerified) {
          await FirebaseFirestore.instance
              .collection("Student")
              .where("UID", isEqualTo: userCredential.user?.uid.toString())
              .where("role", isEqualTo: 'student')
              .get()
              .then((allVerifiedUsers) async {
            if (allVerifiedUsers.docs.length > 0) {
              DocumentSnapshot document = allVerifiedUsers.docs[0];
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('email', _emailController.text);
              prefs.setString('educationLevel', document['educationLevel']);
              prefs.setString('studentName', document['studentName']);
              prefs.setString('fatherName', document['fatherName']);
              prefs.setString('phoneNumber', document['phoneNumber']);
              prefs.setString('sellerImage', document['sellerImage']);

              Get.snackbar(
                "Student successfully login",
                "login!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primaryColor,
                colorText: AppConstant.appTextColor,
              );
              Get.to(DashboardScreen());
            } else {
              Get.snackbar(
                "Error",
                "Only Students are allowed to login here",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primaryColor,
                colorText: AppConstant.appTextColor,
              );
            }
          });
        } else {
          Get.snackbar(
            "Error",
            "Please verify your email before login",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.primaryColor,
            colorText: AppConstant.appTextColor,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Problem with Email or Password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: AppConstant.appTextColor,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context);
            Get.to(welcomescreen());
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              // Email and Password
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: "enter your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.toString().length < 6) {
                    return 'Enter Minimum 6 characters';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: "enter your password",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                ),
              ),

              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: const Text('Forget Password?'),
                ),
              ),

              // Login button
              const SizedBox(height: 10.0),
              CustomBtn(
                onPressed: _loginUser,
                height: 60,
                width: 400.0,
                text: 'Login',
              ),

              const SizedBox(height: 10),
              const Text('Or connect with'),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinkedButton(
                    icon: FontAwesomeIcons.facebook,
                    color: Colors.blueAccent,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  LinkedButton(
                    icon: FontAwesomeIcons.google,
                    color: Colors.red,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  LinkedButton(
                    icon: FontAwesomeIcons.twitter,
                    color: Colors.lightBlue,
                    onPressed: () {},
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    title: 'Don\'t have an account',
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationScreen()),
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class LinkedButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  const LinkedButton({
    Key? key,
    required this.icon,
    required this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            icon,
            size: 30,
            color: color,
          ),
        ),
      ),
    );
  }
}
