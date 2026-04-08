import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_uplift/NGO/screens/auth/Registeration.dart';
import 'package:unity_uplift/NGO/screens/auth/auth_controller.dart';
import 'package:unity_uplift/NGO/screens/auth/change_password.dart';
import 'package:unity_uplift/NGO/screens/auth/forget_passemail.dart';
import 'package:unity_uplift/NGO/screens/dashboard/dashboard_org.dart';
import 'package:unity_uplift/NGO/utils/app_colors.dart';

import '../../../components/custom_btn.dart';
import '../../../utils/app-constant.dart';
import '../welcome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  QuerySnapshot? allUsers = null;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(Welcome());
          },
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Do it later'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo in the center
                  Image.asset("assets/images/logo.png"),
                  const SizedBox(height: 10),

                  // Heading of login on the left
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Email and Password text fields
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: "enter your email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  //   CustomTextfield(text: 'Username'),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: "enter your password",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0)),
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
                  // Forget password text on the left
                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (ForgetPasswordScreen())),
                        );
                      },
                      child: const Text('Forget Password?'),
                    ),
                  ),

                  // Login button in the center
                  const SizedBox(height: 10.0),
                  CustomBtn(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        UserCredential? userCredential =
                            await AuthController.instance.login(context,
                                emailController.text, passwordController.text);
                        if (userCredential != null) {
                          if (userCredential.user!.emailVerified) {
                            await FirebaseFirestore.instance
                                .collection("NGO")
                                .where("UID",
                                    isEqualTo:
                                        userCredential.user?.uid.toString())
                                .where("role", isEqualTo: "NGO")
                                .get()
                                .then((allVerifiedUsers) async {
                              setState(() {
                                allUsers = allVerifiedUsers;
                              });

                              if (allVerifiedUsers.docs.length > 0) {
                                DocumentSnapshot document =
                                    allVerifiedUsers.docs[0];

                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString(
                                    'email_NGO', emailController.text);
                                prefs.setString('address', document['address']);
                                prefs.setString(
                                    'phoneNumber', document['phoneNumber']);
                                prefs.setString('organizationName',
                                    document['organizationName']);
                                prefs.setString('missionAndObjectives',
                                    document['missionAndObjectives']);
                                prefs.setString(
                                    'sellerImage', document['sellerImage']);

                                Get.snackbar(
                                  "Success NGO Login",
                                  "login!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppColors.primaryColor,
                                  colorText: AppConstant.appTextColor,
                                );
                                Get.to(dashboard_NGO());
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Only NGO's are allowed to login here",
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
                    },
                    // color: AppColors.primaryColor, // Set the desired color
                    height: 60,
                    width: 400.0, // Set the desired width
                    text: 'Login',

                    // You can customize the text here
                  ),

                  // "Or connect with" text in the center
                  const SizedBox(height: 10),
                  const Text('Or connect with'),
                  // Facebook, Google, Twitter buttons
                  const SizedBox(height: 5),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     LinkedButton(
                  //       icon: FontAwesomeIcons.facebook,
                  //       color: Colors.blueAccent,
                  //       onPressed: () {
                  //         //      await _loginWithFacebook();
                  //       },
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     LinkedButton(
                  //       icon: FontAwesomeIcons.google,
                  //       color: Colors.red,
                  //       onPressed: () {},
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     LinkedButton(
                  //       icon: FontAwesomeIcons.twitter,
                  //       color: Colors.lightBlue,
                  //       onPressed: () {},
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account ',
                      ),
                      // const Text("Don't have an account?"),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegistrationScreen()),
                          );
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
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
