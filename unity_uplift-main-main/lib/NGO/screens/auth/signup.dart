// import "package:flutter/material.dart";
// import "package:unity_uplift/components/custom_btn.dart";

// import 'package:unity_uplift/NGO/screens/auth/auth_controller.dart';

// import 'package:unity_uplift/NGO/screens/dashboard/dashboard_org.dart';

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmpasswordController =
//       TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     _usernameController.dispose();
//     _passwordController.dispose();
//     _confirmpasswordController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {},
//             child: const Text('Do it later '),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Logo in the center
//               Image.asset("assets/images/logo.png"),
//               const SizedBox(height: 10),

//               // Heading of login on the left
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Register',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ),

//               // Email and Password text fields
//               const SizedBox(
//                 height: 16.0,
//               ),
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: const InputDecoration(
//                     labelText: 'email',
//                     hintText: "enter your email",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(6))),
//                     fillColor: Colors.white,
//                     filled: true,
//                     contentPadding: EdgeInsets.all(12.0)),
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(
//                     labelText: 'Password',
//                     hintText: "enter your password",
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(6))),
//                     filled: true,
//                     contentPadding: EdgeInsets.all(12.0)),
//               ),
//               const SizedBox(height: 10.0),
//               TextFormField(
//                 controller: _confirmpasswordController,
//                 decoration: const InputDecoration(
//                     labelText: 'confirm Password',
//                     hintText: "enter your password",
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(6))),
//                     filled: true,
//                     contentPadding: EdgeInsets.all(12.0)),
//               ),
//               const Spacer(),
//               const SizedBox(height: 10.0),
//               CustomBtn(
//                 onPressed: () {
//                   // if (_passwordController.text ==
//                   //     _confirmpasswordController.text) {
//                   AuthController.instance
//                       .registerUser(
//                           _usernameController.text, _passwordController.text)
//                       .then((value) => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => dashboard(),
//                           )));
//                   // _signUp();
//                   //}
//                 },
//                 // color: AppColors.primaryColor, // Set the desired color
//                 height: 60,
//                 width: 400.0, // Set the desired width
//                 text: 'SignUp',

//                 // You can customize the text here
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
