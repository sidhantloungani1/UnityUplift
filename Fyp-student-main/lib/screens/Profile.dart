import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/utils/app_colors.dart';

import '../utils/app-constant.dart';

class studentProfilePage extends StatefulWidget {
  studentProfilePage({super.key});
  @override
  State<studentProfilePage> createState() => _studentProfilePageState();
}

class _studentProfilePageState extends State<studentProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _phoneController = TextEditingController();

  String valueChoose = "Bachelors";
  List<String> listItem = ["Intermediate", "Bachelors", "Masters"];

  var educationLevel;

  var studentName;
  var fatherName;
  var phoneNumber;
  var sellerImage;

  @override
  void dispose() {
    _studentNameController.dispose();
    _fatherNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  var isLoading = false.obs;

  //Image Data
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  String sellerImageUrl = "";
  late final user;

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  Future<void> loadData() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    educationLevel = prefs.getString('educationLevel');
    studentName = prefs.getString('studentName');
    fatherName = prefs.getString('fatherName');
    phoneNumber = prefs.getString('phoneNumber');
    sellerImage = prefs.getString('sellerImage');

    _studentNameController.text = studentName.toString();
    _fatherNameController.text = fatherName.toString();
    _phoneController.text = phoneNumber.toString();
    valueChoose = educationLevel.toString();
    imageXFile = null;
    sellerImageUrl = prefs.getString('sellerImage')!;
    isLoading.value = false;
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    loadData();

    super.initState();
  }

  Future deleteStorageImage(String url) async {
    try {
      await firebase_storage.FirebaseStorage.instance.ref(url).delete();
      return true;
    } catch (e) {
      debugPrint('Error deleting $url: $e');
      return false;
    }
  }

  Future updateStudentProfile() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else if (imageXFile != null) {
      isLoading.value = true;

      deleteStorageImage(sellerImage);
      // Call to Car register controleer
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("profilepic")
          .child(fileName);
      firebase_storage.UploadTask uploadTask =
          reference.putFile(File(imageXFile!.path));
      firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) {
        sellerImageUrl = url;
      });
    }

    _updateData();
  }

  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('Student')
          .doc(uid)
          .update(data);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('educationLevel', valueChoose);
      prefs.setString('studentName', _studentNameController.text);
      prefs.setString('fatherName', _fatherNameController.text);
      prefs.setString('phoneNumber', _phoneController.text);
      prefs.setString('sellerImage', sellerImageUrl);

      isLoading.value = false;

      Get.snackbar(
        "Your Profile is updated successfully",
        "added in the Database",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: AppConstant.appTextColor,
      );
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  void _updateData() {
    final Map<String, dynamic> data = {
      'educationLevel': valueChoose,
      'fatherName': _fatherNameController.text,
      'phoneNumber': _phoneController.text,
      'sellerImage': sellerImageUrl,
      'studentName': _studentNameController.text,
    };
    updateUserData(user.uid, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() => isLoading.value
                    ? const CircularProgressIndicator()
                    : Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Profile Picture',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Icon, heading, browse link, supported formats tagline
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 180,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          _getImage();
                                        },
                                        child: CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          backgroundColor: Colors.black26,
                                          backgroundImage: imageXFile == null
                                              ? null
                                              : FileImage(
                                                  File(imageXFile!.path)),
                                          child: imageXFile == null
                                              ? Icon(
                                                  Icons.add_photo_alternate,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  color: Colors.grey,
                                                )
                                              : null,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),

                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _studentNameController,
                              decoration: const InputDecoration(
                                labelText: 'Student Name',
                                hintText: "Enter Your Name",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                hintText: "Enter Your Phone Number",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
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
                                  backgroundColor: AppColors.primaryColor,
                                  fixedSize: const Size(380, 50),
                                ),
                                onPressed: isLoading.value
                                    ? null
                                    : () => updateStudentProfile(),
                                icon: isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Icon(
                                        Icons.upload,
                                        color: Colors.white,
                                      ),
                                label: Text(
                                  isLoading.value
                                      ? 'Processing'
                                      : 'Update Profile',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ],
                        ))))));
  }
}
