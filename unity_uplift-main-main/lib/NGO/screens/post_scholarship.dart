import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:unity_uplift/NGO/screens/scholarshiplist.dart";
import "package:unity_uplift/NGO/utils/app_colors.dart";
import "package:unity_uplift/components/custom_btn.dart";

import "../../utils/app-constant.dart";

class postscholarship extends StatefulWidget {
  const postscholarship({super.key});

  @override
  State<postscholarship> createState() => _postscholarshipState();
}

class _postscholarshipState extends State<postscholarship> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;

  String valueChoose = "Intermediate";
  List listItem = ["Intermediate", "Bachelors", "Masters"];

  String selectedScholarship = "meritbase scholarship";
  List scholarshipList = [
    "meritbase scholarship",
    "international scholarship",
  ];
  String selectedLocation = 'Select Location';
  List pakistanCities = [
    'Select Location',
    'Islamabad',
    'Karachi',
    'Lahore',
    'Faisalabad',
    'Rawalpindi',
    'Multan',
    'Peshawar',
    'Quetta',
    'Sialkot',
    'Gujranwala',
    'Abbottabad',
    'Bahawalpur',
    'Sargodha',
    'Sukkur',
    'Larkana',
    'Hyderabad',
    'Mirpur (Azad Kashmir)',
    'Mardan',
    'Gujrat',
    'Sahiwal',
    // Add more cities as needed
  ];

  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  final _scholarshipTitle = TextEditingController();
  final _NGOName = TextEditingController();
  final _eligibilityCriteria = TextEditingController();
  final _scholarshipDescription = TextEditingController();

  @override
  void dispose() {
    _scholarshipTitle.dispose();
    _NGOName.dispose();
    _eligibilityCriteria.dispose();
    _scholarshipDescription.dispose();
    super.dispose();
  }

  Future<void> _applyScholarship() async {
    if (_formKey.currentState!.validate()) {
      //isLoading.value = true;
      try {
        final User? user = auth.currentUser;
        if (user != null) {
          final userDoc = FirebaseFirestore.instance
              .collection('AvailableScholarships')
              .add({
            'scholarshipTitle': _scholarshipTitle.text.trim(),
            'NGOName': _NGOName.text.trim(),
            'eligibilityCriteria': _eligibilityCriteria.text.trim(),
            'educationLevel': valueChoose.toString(),
            'scholarshipType': selectedScholarship.toString(),
            'scholarshipDescription': _scholarshipDescription.text.trim(),
            'NGOUID': user.uid.toString(),
            'ExpiryDate': Timestamp.fromDate(selectedDate),
          });
        }
        Get.to(const ScholarshipList());
        // Navigate to the next screen or show a success message
        print('Registration successful!');
        Get.snackbar(
          "Successfully",
          "Added new scholarship",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: AppConstant.appTextColor,
        );
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
        print('Scholarship registration is failed: $e');
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(
            content: Text('Scholarship registration is failed:'),
          ),
        );
      }
    }
    /* .doc(DateTime.now().microsecond.toString() + "TEstinddddddddd");
      await userDoc.set({
        'scholarshipTitle': _scholarshipTitle.text.trim(),
        'NGOName': _NGOName.text.trim(),
        'eligibilityCriteria': _eligibilityCriteria.text.trim(),
        'educationLevel': valueChoose.toString(),
        'scholarshipType': selectedScholarship.toString(),
        'scholarshipDescription': _scholarshipDescription.text.trim(),
        'NGOUID': user.uid.toString(),
        'ExpiryDate': Timestamp.fromDate(selectedDate),
      });*/

    /* FirebaseFirestore.instance.collection('yourCollection').add({
        'data': 'yourData',
        'deleteAt': Timestamp.fromDate(DateTime(2024, 6, 26)),
      });
      self.db.collection("collection")
    .whereField("expiresAt", isGreaterThanOrEqualTo: startTimestamp)*/
  }

  // Function to show date picker
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context);
            Get.to(const ScholarshipList());
          },
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Do it later'),
          ),
        ],
      ),
      //appbar
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
                    'Post Scholarship',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Increase the scolarship program',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _scholarshipTitle,
                    decoration: const InputDecoration(
                        labelText: 'Scholarship Title',
                        hintText: "Tittle",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Scholarship Title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _NGOName,
                    decoration: const InputDecoration(
                        labelText: 'NGO Name',
                        hintText: "Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the NGO Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _eligibilityCriteria,
                    decoration: const InputDecoration(
                        labelText: ' eligibility critera',
                        hintText: "Address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        child: DropdownButton(
                          dropdownColor:
                              const Color.fromARGB(255, 230, 228, 228),
                          padding: const EdgeInsets.all(12.0),
                          value: valueChoose,
                          onChanged: (newValue) {
                            setState(() {
                              valueChoose = newValue as String;
                            });
                          },
                          underline:
                              Container(), // Remove the default underline
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          items: listItem.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                      ),
                      //second container
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        child: DropdownButton(
                          dropdownColor:
                              const Color.fromARGB(255, 199, 199, 199),
                          padding: const EdgeInsets.all(12.0),
                          value: selectedScholarship,
                          onChanged: (newValue) {
                            setState(() {
                              selectedScholarship = newValue.toString();
                            });
                          },
                          underline:
                              Container(), // Remove the default underline
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          items: scholarshipList.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'About the Scholarship',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Description',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _scholarshipDescription,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        labelText: 'Details of scholarship',
                        hintText: "write here",
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Deadline',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Date Field
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Row(children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.calendar_today,
                                color:
                                    Colors.grey, // Adjust the color as needed
                              ),
                            ),
                            Text(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ]),
                        ),
                      ),
                      /* Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      child: DropdownButton(
                        dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                        padding: const EdgeInsets.all(2.0),
                        value: selectedLocation,
                        onChanged: (newValue) {
                          setState(() {
                            selectedLocation = newValue as String;
                          });
                        },
                        underline: Container(), // Remove the default underline
                        icon: const Icon(Icons.arrow_drop_down,
                            size: 20, color: Color.fromARGB(255, 0, 0, 0)),
                        items: pakistanCities.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ),*/
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomBtn(
                    onPressed: () {
                      _applyScholarship();
                    },
                    height: 60,
                    width: 400.0,
                    text: 'Apply Next ',
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
