import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app-constant.dart';
import 'PaymentScreen.dart';

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;

  var isLoading = false.obs;

  final TextEditingController _donorNameController = TextEditingController();
  final TextEditingController _donorEmailController = TextEditingController();
  final TextEditingController _donorContactController = TextEditingController();
  final TextEditingController _donationAmountController =
      TextEditingController();
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _studentUniversityController =
      TextEditingController();
  final TextEditingController _studentCourseController =
      TextEditingController();

  Future<void> _donateToStudent() async {
    if (_formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final User? user = auth.currentUser;
        if (user != null) {
          final userDoc =
              FirebaseFirestore.instance.collection('DonationToStudent').add({
            'donorName': _donorNameController.text,
            'donorEmail': _donorEmailController.text,
            'donorContact': _donorContactController.text,
            'donationAmount': _donationAmountController.text,
            'studentName': _studentNameController.text,
            'InstituteName': _studentUniversityController.text,
            'DonorUID': user.uid.toString(),
            'CourseName': _studentCourseController.text,
          });
        }
        Get.to(PaymentScreen());
        // Navigate to the next screen or show a success message
        print('Registration successful!');
        Get.snackbar(
          "Successfully",
          "donated to Student",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appScendoryColor,
          colorText: AppConstant.appTextColor,
        );
      } on FirebaseAuthException catch (e) {
        //isLoading.value = false;
        // Handle Firebase Auth exceptions
        print('Authentication failed: $e');
        Get.snackbar(
          "Authentication Failed",
          "donated to Student",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appScendoryColor,
          colorText: AppConstant.appTextColor,
        );
      } catch (e) {
        // Handle any other exceptions
        // isLoading.value = false;
        print('Donation transfer is failed: $e');
        Get.snackbar(
          "Donation",
          "transfer is failed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appScendoryColor,
          colorText: AppConstant.appTextColor,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Donor and student details',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        backgroundColor: const Color(0xFF4350AF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Donor Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildInputField(_donorNameController, 'Name'),
                  const SizedBox(height: 10),
                  _buildInputField(_donorEmailController, 'Email'),
                  const SizedBox(height: 10),
                  _buildInputField(_donorContactController, 'Contact'),
                  const SizedBox(height: 10),
                  _buildInputField(
                      _donationAmountController, 'Donation Amount'),
                  const SizedBox(height: 20),
                  const Text(
                    'Student Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildInputField(_studentNameController, 'Student Name'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                            _studentUniversityController, 'University/College'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildInputField(
                            _studentCourseController, 'Course Name'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _donateToStudent();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4350AF),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field should not be empty';
        }
        return null;
      },
    );
  }
}
