import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_uplift/NGO/utils/app_colors.dart';

import '../../utils/app-constant.dart';
import '../screens/dashboard/dashboard_org.dart';

class NGOProfilePage extends StatefulWidget {
  NGOProfilePage({super.key});
  @override
  State<NGOProfilePage> createState() => _NGOProfilePageState();
}

class _NGOProfilePageState extends State<NGOProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _NGONameController = TextEditingController();
  final _taglineController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  var missionAndObjectives;
  var organizationName;
  var phoneNumber;
  var address;
  var sellerImage;

  @override
  void dispose() {
    _NGONameController.dispose();
    _taglineController.dispose();
    _addressController.dispose();
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
    address = prefs.getString('address');
    phoneNumber = prefs.getString('phoneNumber');
    organizationName = prefs.getString('organizationName');
    missionAndObjectives = prefs.getString('missionAndObjectives');
    sellerImage = prefs.getString('sellerImage');

    _NGONameController.text = organizationName.toString();
    _taglineController.text = missionAndObjectives.toString();
    _phoneController.text = phoneNumber.toString();
    _addressController.text = address.toString();

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
      await FirebaseFirestore.instance.collection('NGO').doc(uid).update(data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('organizationName', _NGONameController.text);
      prefs.setString('missionAndObjectives', _taglineController.text);
      prefs.setString('address', _addressController.text);
      prefs.setString('phoneNumber', _phoneController.text);
      prefs.setString('sellerImage', sellerImageUrl);

      isLoading.value = false;
      Get.to(const dashboard_NGO());

      Get.snackbar(
        "Your Product is updated successfully",
        "added in the Database",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: AppConstant.appTextColor,
      );
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  Future<void> _updateData() async {
    final Map<String, dynamic> data = {
      'address': _addressController.text,
      'missionAndObjectives': _taglineController.text,
      'phoneNumber': _phoneController.text,
      'sellerImage': sellerImageUrl,
      'organizationName': _NGONameController.text,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('sellerImage', sellerImageUrl);
    updateUserData(user.uid, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
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
                                  fontSize: 25, fontWeight: FontWeight.bold),
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
                            const Text(
                              'Sidhant Kumar',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _NGONameController,
                              decoration: const InputDecoration(
                                labelText: 'NGO Name',
                                hintText: "Enter Your NGO Name",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the NGO name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _taglineController,
                              decoration: const InputDecoration(
                                labelText: 'Mission',
                                hintText: "Enter Mission details",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Tag  line';
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
                                labelText: 'Address',
                                hintText: "Enter Address",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter  Address';
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
                            const SizedBox(height: 20.0),

                            Obx(
                              () => ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: (AppColors.primaryColor),
                                  fixedSize: const Size(380, 50),
                                ),
                                onPressed: isLoading.value
                                    ? null
                                    : () => updateStudentProfile(),
                                icon: isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Icon(Icons.upload),
                                label: Text(
                                  isLoading.value
                                      ? 'Processing'
                                      : 'UPDATE NGO PROFILE',
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ],
                        ))))));
  }
}
