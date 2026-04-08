// import 'package:firebase_auth/firebase_auth.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:unity_uplift/NGO/screens/welcome_screen.dart';
import 'package:unity_uplift/controllers/payment_controller.dart';
import 'package:unity_uplift/firebase_options.dart';

import 'utils/app-constant.dart';
//import 'package:unity_uplift/screens/welcome.dart';

// import 'package:unity_uplift/services/firebase_service.dart';

bool? appTheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = AppConstant.stripePublishKey;
  await Stripe.instance.applySettings();
  // final theme = await AdaptiveTheme.getThemeMode();
  // theme == AdaptiveThemeMode.light ? appTheme = true : appTheme = false;
  // print('object $appTheme $theme');

//   FirebaseAuth auth = FirebaseAuth.instance;
//  try {
//       UserCredential userCredential = await auth
//           .createUserWithEmailAndPassword(
//               email: "oomerhassan7@gmail.com",
//               password: "omer6290",);
//               print(userCredential.user!.uid.toString());
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }

  // final data = await FirebaseService('test').post({'name': 'anas'});
  runApp(MyApp(
      // initialTheme: theme,
      ));
}

class MyApp extends StatefulWidget {
  // final AdaptiveThemeMode? initialTheme;
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkTheme();
  }

  AdaptiveThemeMode? theme;

  checkTheme() async {
    theme = await AdaptiveTheme.getThemeMode();
    theme == AdaptiveThemeMode.light ? appTheme = true : appTheme = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: Colors.blue,
        ),
        dark: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.blue,
        ),
        initial: theme ?? AdaptiveThemeMode.light,
        builder: (lightTheme, darkTheme) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            // home: SettingsPage(),
            home: const welcomescreen(),
          );
        });
  }
}
