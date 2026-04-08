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
import '../screens/donor_dashboard.dart';

class DonorProfilePage extends StatefulWidget {
  DonorProfilePage({super.key});
  @override
  State<DonorProfilePage> createState() => DonorProfilePageState();
}

class DonorProfilePageState extends State<DonorProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _donorNameController = TextEditingController();
  final _donorCityController = TextEditingController();
  final _donoraddressController = TextEditingController();
  final _donorphoneController = TextEditingController();

  var donorName;
  var donorAddress;
  var donorCity;
  var donorPhoneNumber;
  var donorSellerImage;

  @override
  void dispose() {
    _donorNameController.dispose();
    _donorCityController.dispose();
    _donoraddressController.dispose();
    _donorphoneController.dispose();
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
    donorAddress = prefs.getString('address_donor');
    donorPhoneNumber = prefs.getString('phoneNumber_donor');
    donorName = prefs.getString('name_donor');
    donorCity = prefs.getString('city_donor');
    donorSellerImage = prefs.getString('sellerImage_donor');

    _donorNameController.text = donorName.toString();
    _donorCityController.text = donorCity.toString();
    _donoraddressController.text = donorAddress.toString();
    _donorphoneController.text = donorPhoneNumber.toString();

    imageXFile = null;
    sellerImageUrl = prefs.getString('sellerImage_donor')!;
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

      deleteStorageImage(donorSellerImage);
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
          .collection('DONOR')
          .doc(uid)
          .update(data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name_donor', _donorNameController.text);
      prefs.setString('address_donor', _donoraddressController.text);
      prefs.setString('city_donor', _donorCityController.text);
      prefs.setString('phoneNumber_donor', _donorphoneController.text);
      prefs.setString('sellerImage_donor', sellerImageUrl);

      isLoading.value = false;
      Get.to(donor_DrawerWidget());

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
      'donorName': _donorNameController.text,
      'donorAddress': _donoraddressController.text,
      'donorCity': _donorCityController.text,
      'donorImageURL': sellerImageUrl,
      'donorPhoneNumber': _donorphoneController.text,
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
                    ? CircularProgressIndicator()
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
                              controller: _donorNameController,
                              decoration: const InputDecoration(
                                labelText: 'Donor Name',
                                hintText: "Enter Donor Name",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the Donor name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _donoraddressController,
                              decoration: const InputDecoration(
                                labelText: 'Address',
                                hintText: "Enter Donor Address",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Donor Address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _donorCityController,
                              decoration: const InputDecoration(
                                labelText: 'City',
                                hintText: "Enter Donor City",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter  City';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _donorphoneController,
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
                                  fixedSize: const Size(380, 60),
                                ),
                                onPressed: isLoading.value
                                    ? null
                                    : () => updateStudentProfile(),
                                icon: isLoading.value
                                    ? CircularProgressIndicator()
                                    : const Icon(
                                        Icons.upload,
                                        color: Colors.white,
                                      ),
                                label: Text(
                                  isLoading.value
                                      ? 'Processing'
                                      : 'Update  Donor Profile',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ],
                        ))))));
  }
}
