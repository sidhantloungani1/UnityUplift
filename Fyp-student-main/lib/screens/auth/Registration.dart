import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/screens/auth/Login_Screen.dart';
import 'package:student/utils/app_colors.dart';

import '../../utils/app-constant.dart';
import '../Welcome.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _departmentNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  String valueChoose = "Bachelors";
  List<String> listItem = ["Intermediate", "Bachelors", "Masters"];

  @override
  void dispose() {
    _studentNameController.dispose();
    _fatherNameController.dispose();
    _departmentNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  var isLoading = false.obs;

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String sellerImageUrl = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  Future<void> _registerUser() async {
    if (imageXFile == null) {
      Get.snackbar(
        "Select Image",
        "Profile",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: AppConstant.appTextColor,
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final user = userCredential.user;
        // send email verification
        await userCredential.user!.sendEmailVerification();

        if (user != null) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference reference = fStorage.FirebaseStorage.instance
              .ref()
              .child("profilepic")
              .child(fileName);
          fStorage.UploadTask uploadTask =
              reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            sellerImageUrl = url;
          });
          final userDoc =
              FirebaseFirestore.instance.collection('Student').doc(user.uid);
          await userDoc.set({
            'studentName': _studentNameController.text.trim(),
            'fatherName': _fatherNameController.text.trim(),
            'educationLevel': valueChoose.toString(),
            'email': _emailController.text.trim(),
            'password': _passwordController.text.trim(),
            'phoneNumber': _phoneController.text.trim(),
            'sellerImage': sellerImageUrl,
            'role': 'student',
            'UID': userCredential.user?.uid.toString(),
            'status': "not approved"
          });
          Get.to(const LoginScreen());
          // Navigate to the next screen or show a success message
          print('Registration successful!');
          Get.snackbar(
            "Successfully",
            "Register!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.primaryColor,
            colorText: AppConstant.appTextColor,
          );
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        // Handle Firebase Auth exceptions
        print('Registration failed: $e');
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'An error occurred'),
          ),
        );
      } catch (e) {
        // Handle any other exceptions
        isLoading.value = false;
        print('Registration failed: $e');
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(
            content: Text('An error occurred'),
          ),
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
            Get.to(const welcomescreen());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Picture',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Icon, heading, browse link, supported formats tagline
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 180,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              _getImage();
                            },
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 5,
                              backgroundColor: Colors.black26,
                              backgroundImage: imageXFile == null
                                  ? null
                                  : FileImage(File(imageXFile!.path)),
                              child: imageXFile == null
                                  ? Icon(
                                      Icons.add_photo_alternate,
                                      size:
                                          MediaQuery.of(context).size.width / 6,
                                      color: Colors.grey,
                                    )
                                  : null,
                            )),
                        /*   Container(
                            margin: const EdgeInsets.only(right: 20, top: 20),
                            alignment: Alignment.bottomRight,
                            child: const Text(
                              "Upload Image",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )*/
                      ],
                    ),
                  ),
                ),
                const Text(
                  'Personal Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _studentNameController,
                  decoration: const InputDecoration(
                    labelText: 'Student Name',
                    hintText: "Enter Your Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _fatherNameController,
                  decoration: const InputDecoration(
                    labelText: 'Father Name',
                    hintText: "Enter Father Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Father Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  value: valueChoose,
                  onChanged: (newValue) {
                    setState(() {
                      valueChoose = newValue!;
                    });
                  },
                  items: listItem.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Education Level',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      'Contact Infornation',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: "Enter Your Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
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
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: "Enter Your Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: "Enter Your Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),

                Obx(
                  () => ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (AppColors.primaryColor),
                      fixedSize: const Size(380, 50),
                    ),
                    onPressed: isLoading.value ? null : () => _registerUser(),
                    icon: isLoading.value
                        ? const CircularProgressIndicator()
                        : const Icon(
                            Icons.upload,
                            color: Colors.white,
                          ),
                    label: Text(
                      isLoading.value ? 'Processing' : 'Register Student',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
