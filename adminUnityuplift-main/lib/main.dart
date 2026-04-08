import 'package:empower_admin_portal/main_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'authentication/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBrXkpKn-bKOx9ejCRUXV0PtG2CFDSSGEc",
          authDomain: "unity-uplift.firebaseapp.com",
          projectId: "unity-uplift",
          storageBucket: "unity-uplift.appspot.com",
          messagingSenderId: "313729187200",
          appId: "1:313729187200:web:1d3ec2736e2118fa5c1565"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin-Portal',
      theme: ThemeData(primarySwatch: Colors.green),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginScreen()
          : const HomeScreen(),
    );
  }
}
