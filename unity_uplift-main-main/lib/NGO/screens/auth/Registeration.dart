// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unity_uplift/NGO/utils/app_colors.dart';

import '../../../utils/app-constant.dart';
import '../welcome.dart';
import 'Login_Screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _orgNameController = TextEditingController();
  final _missionController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _downloadURL;

  @override
  void dispose() {
    _orgNameController.dispose();
    _missionController.dispose();
    _addressController.dispose();
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
              FirebaseFirestore.instance.collection('NGO').doc(user.uid);
          await userDoc.set({
            'organizationName': _orgNameController.text.trim(),
            'missionAndObjectives': _missionController.text.trim(),
            'address': _addressController.text.trim(),
            'email': _emailController.text.trim(),
            'phoneNumber': _phoneController.text.trim(),
            'sellerImage': sellerImageUrl,
            'role': 'NGO',
            'UID': userCredential.user?.uid.toString(),
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
        // Handle Firebase Auth exceptions
        isLoading.value = false;
        print('Registration failed: $e');
        Get.snackbar(
          "An error",
          "Occured!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: AppConstant.appTextColor,
        );
      } catch (e) {
        // Handle any other exceptions
        print('Registration failed: $e');
        isLoading.value = false;
        Get.snackbar(
          "An error",
          "Occured!",
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
            Get.to(const Welcome());
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
                  /* decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(90)),
                      gradient: LinearGradient(
                          colors: [
                            (new Color(0xffF5591F)),
                            (new Color(0xffF2861E))
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),*/
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
                  controller: _orgNameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: "Name Of Organization",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the organization name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _missionController,
                  decoration: const InputDecoration(
                    labelText: 'Tagline',
                    hintText: "Mission and Objective",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the mission and objectives';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: ' Adress',
                    hintText: "Adress Of Organization",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Contact Information',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // Add functionality for adding email field
                      },
                      child: const Text('+Email'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // Add functionality for adding phone field
                      },
                      child: const Text('+Phone'),
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
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
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
                  height: 8,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
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
                    } else if (value.toString().length < 6) {
                      return 'Enter Minimum 6 characters';
                    } else {
                      return null;
                    }
                  },
                ),

                const SizedBox(height: 10),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: ' Phone Number',
                    hintText: "Enter Your Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  /*validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },*/
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Required"),
                    // MaxLengthValidator(11, errorText: "Max 11 digits allowed"),
                    MinLengthValidator(6, errorText: "Min 6 digits required"),
                    PatternValidator(r'^(?:[+0][1-9])?[0-9]{10,12}$',
                        errorText: 'error'),

                    //(errorText: " Not valid")
                  ]),
                ),
                // Conditional rendering of email and phone text fields based on user action

                const SizedBox(height: 20),

                /* Center(
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(8),
                    padding: const EdgeInsets.all(6),
                    color: const Color(0xff384EB7),
                    child: GestureDetector(
                      onTap: () {
                        _selectFile(context); // Call function to select file
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _selectFile(
                                  context); // Call function to select file
                            },
                            icon: const Icon(
                              FontAwesomeIcons.cloudArrowUp,
                              size: 30, // Adjust the size as needed
                            ),
                          ),
                          const Text(
                            'Upload your file here',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                          TextButton(
                            onPressed: () {
                              _selectFile(
                                  context); // Call function to select file
                            },
                            child: const Text('Browse'),
                          ),
                          const Text(
                            'Supported formats: JPEG, PNG, GIF, MP4, PDF, PSD, AI, Word, PPT',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Upload Progress:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const LinearProgressIndicator(
                  value: 0, // Initially show no progress
                  minHeight: 10,
                  backgroundColor: Color.fromARGB(255, 28, 29, 99),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Uploading File',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),*/
                // File upload progress bar and details

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
                    label: Text(isLoading.value ? 'Processing' : 'REGISTER NGO',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* Future<void> _selectFile(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File file = File(pickedFile.path);
        String? downloadURL = await uploadDocument(file, context);
        if (downloadURL != null) {
          setState(() {
            _downloadURL = downloadURL;
          });
          // Show Snackbar with uploaded file name and green color
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green, // Change color to green
              content: Row(
                children: [
                  const Icon(Icons.check),
                  const SizedBox(width: 8),
                  Text('File uploaded: ${basename(file.path)}'),
                ],
              ),
            ),
          );
        }
      }
    } catch (e) {
      // Handle errors
      print('File selection failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File selection failed: $e'),
        ),
      );
    }
  }

  Future<String?> uploadDocument(File file, BuildContext context) async {
    try {
      // Create a reference to the location you want to upload to in Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('documents/${basename(file.path)}');

      // Upload the file to Firebase Storage
      final uploadTask = ref.putFile(file);

      // Wait for the upload to complete
      await uploadTask.whenComplete(() {});

      // Get the download URL for the uploaded file
      String downloadURL = await ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      // Handle errors
      print('Upload failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upload failed: $e'),
        ),
      );
      return null;
    }
  }*/
}
