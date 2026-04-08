import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/screens/Dashboard.dart';
import 'package:student/screens/success.dart';

import '../../components/custom_btn.dart';
import '../utils/app-constant.dart';

class ApplyForScholarshipPage extends StatefulWidget {
  const ApplyForScholarshipPage({Key? key}) : super(key: key);

  @override
  State<ApplyForScholarshipPage> createState() =>
      _ApplyForScholarshipPageState();
}

class _ApplyForScholarshipPageState extends State<ApplyForScholarshipPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  List<Item> _items = [];
  Item? _selectedItem;
  bool _isLoading = true;

  String _currentNGOName = "";
  String _currentNGOUID = "";
  String _currentscholarshipTitle = "";

  String selectedScholarship = "";
  List<String> scholarshipList = [""];
  String? educationLevel;

  final collectionRef =
      FirebaseFirestore.instance.collection('AvailableScholarships');
  @override
  Future<void> _getScholarshipList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    educationLevel = prefs.getString('educationLevel');
    //final querySnapshot = await collectionRef.where('educationLevel', isEqualTo: 'Bachelors').get();
    final result = await collectionRef
        .where('educationLevel', isEqualTo: educationLevel)
        .where('ExpiryDate', isGreaterThan: Timestamp.now())
        .get();

    for (int i = 0; i < result.docs.length; i++) {
      DocumentSnapshot document = result.docs[i];
      scholarshipList.add(document['scholarshipTitle']);
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _aboutController = TextEditingController();
  final _addressController = TextEditingController();
  final _scholarshipController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _aboutController.dispose();
    _addressController.dispose();
    _scholarshipController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchItems(); // Run method before widget build
  }

  Future<void> _fetchItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      educationLevel = prefs.getString('educationLevel');
      //final querySnapshot = await collectionRef.where('educationLevel', isEqualTo: 'Bachelors').get();
      QuerySnapshot snapshot = await collectionRef
          .where('educationLevel', isEqualTo: educationLevel)
          .where('ExpiryDate', isGreaterThan: Timestamp.now())
          .orderBy('ExpiryDate')
          .get();
      // QuerySnapshot snapshot =
      //    await FirebaseFirestore.instance.collection('items').get();
      List<Item> items = snapshot.docs.map((doc) {
        return Item(
          NGOName: doc['NGOName'],
          NGOUID: doc['NGOUID'],
          scholarshipTitle: doc['scholarshipTitle'],
        );
      }).toList();
      setState(() {
        _items = items;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching items: $e');
    }
  }

  Future<void> _applyScholarship() async {
    if (_formKey.currentState!.validate()) {
      //isLoading.value = true;
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var educationLevel = prefs.getString('educationLevel');
        final User? user = auth.currentUser;
        if (user != null) {
          final userDoc =
              FirebaseFirestore.instance.collection('scholarshipRequest').add({
            'firstName': _firstNameController.text.trim(),
            'lastName': _lastNameController.text.trim(),
            'about': _aboutController.text.trim(),
            'educationLevel': educationLevel.toString(),
            'address': _addressController.text.trim(),
            'scholarship': _currentscholarshipTitle,
            'Description': _descriptionController.text.trim(),
            'status': "in progress",
            'NGOUID': _currentNGOUID,
            'DOB': selectedDate,
          });
          /*.doc(DateTime.now().millisecond.toString());
        await userDoc.set();*/
          Get.to(ProcessCompleteScreen());
          // Navigate to the next screen or show a success message
          print('Registration successful!');
          Get.snackbar(
            "Successfully",
            "apply scholarship",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppConstant.appScendoryColor,
            colorText: AppConstant.appTextColor,
          );
        }
      } on FirebaseAuthException catch (e) {
        //isLoading.value = false;
        // Handle Firebase Auth exceptions
        print('Authentication failed: $e');
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'User not recognised'),
          ),
        );
      } catch (e) {
        // Handle any other exceptions
        // isLoading.value = false;
        print('Scholarship applicaation is failed: $e');
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(
            content: Text('Scholarship applicaation is failed:'),
          ),
        );
      }
    }
  }

  /* Future<void> _applyScholarship() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var educationLevel = prefs.getString('educationLevel');
      final User? user = auth.currentUser;
      if (user != null) {
        final userDoc =
            FirebaseFirestore.instance.collection('scholarshipRequest').add({
          'firstName': _firstNameController.text.trim(),
          'lastName': _lastNameController.text.trim(),
          'about': _aboutController.text.trim(),
          'educationLevel': educationLevel.toString(),
          'address': _addressController.text.trim(),
          'scholarship': selectedScholarship.toString(),
          'Description': _descriptionController.text.trim(),
          'status': "in progress",
          'NGO
        });
        /*.doc(DateTime.now().millisecond.toString());
        await userDoc.set();*/
        Get.to(ProcessCompleteScreen());
        // Navigate to the next screen or show a success message
        print('Registration successful!');
        Get.snackbar(
          "Successfully",
          "apply scholarship",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appScendoryColor,
          colorText: AppConstant.appTextColor,
        );
      }
    } on FirebaseAuthException catch (e) {
      //isLoading.value = false;
      // Handle Firebase Auth exceptions
      print('Authentication failed: $e');
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'User not recognised'),
        ),
      );
    } catch (e) {
      // Handle any other exceptions
      // isLoading.value = false;
      print('Scholarship applicaation is failed: $e');
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text('Scholarship applicaation is failed:'),
        ),
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(DashboardScreen());
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
                  'Apply For Scholarship',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Increase the scholarship program',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    hintText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the First Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Last Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _aboutController,
                  decoration: const InputDecoration(
                    labelText: 'About',
                    hintText: 'Tell Us Breifly About You',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the About Information';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Parmanent Address',
                    hintText: 'Write Your Parmanent Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Permanent Address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                /*DropdownButtonFormField<String>(
                value: selectedScholarship,
                onChanged: (newValue) {
                  setState(() {
                    selectedScholarship = newValue!;
                  });
                },
                items: scholarshipList.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Select Scholarship',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
              ),*/
                // DropdownExample(),
                Container(
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : DropdownButton<Item>(
                          hint: Text('Select Item'),
                          value: _selectedItem,
                          onChanged: (Item? newValue) {
                            setState(() {
                              _selectedItem = newValue;
                              _currentNGOName = newValue!.NGOName;
                              _currentNGOUID = newValue!.NGOUID;
                              _currentscholarshipTitle =
                                  newValue!.scholarshipTitle;
                            });
                          },
                          items: _items.map((Item item) {
                            return DropdownMenuItem<Item>(
                              value: item,
                              child: Row(
                                children: <Widget>[
                                  Text(item.scholarshipTitle),
                                  SizedBox(width: 10),
                                  Text('${item.NGOName}'),
                                ],
                              ),
                            );
                          }).toList(),
                          /* validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Permanent Address';
                      }
                      return null;
                    },*/
                        ),
                ),

                const SizedBox(height: 15),
                const Text(
                  'What Experience do you have',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Write here',
                    hintText: 'Write details here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        height: 50,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Add another text field or dropdown here as needed
                  ],
                ),
                const SizedBox(height: 15),
                CustomBtn(
                  onPressed: () {
                    _applyScholarship();
                  },
                  height: 60,
                  width: 400.0,
                  text: 'Apply Next',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Item {
  final String NGOName;
  final String NGOUID;
  final String scholarshipTitle;

  Item(
      {required this.NGOName,
      required this.NGOUID,
      required this.scholarshipTitle});
}
