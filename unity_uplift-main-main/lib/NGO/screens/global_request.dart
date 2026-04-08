import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unity_uplift/NGO/screens/student_applicationDetails.dart';
import 'package:unity_uplift/components/custom_btn.dart';

import '../models/drawer.dart';
import '../models/scholarship_model.dart';

class ApplicantRequest extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applicant Requests'),
        /* actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Get.to(dashboard_NGO());
            },
          ),
        ],*/
      ),
      endDrawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Applicant Requests',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              /*child: ListView(
                children: [
                  ScholarshipCard(
                    onAccept: () {
                      // Handle accept action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Accepted')),
                      );
                    },
                    onReject: () {
                      // Handle reject action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Rejected')),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ScholarshipCard(
                    onAccept: () {
                      // Handle accept action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Accepted')),
                      );
                    },
                    onReject: () {
                      // Handle reject action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Rejected')),
                      );
                    },
                  ),
                  // Add more ScholarshipCard widgets as needed
                ],
              ),*/
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('scholarshipRequest')
                    .where('status', isEqualTo: 'in progress')
                    .where('NGOUID', isEqualTo: user.uid.toString())
                    .snapshots(),
                //FirebaseFirestore.instance.collection('categories').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: const Text("Error"),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 50,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(documents[index].data());
                          DocumentSnapshot document = documents[index];
                          ScholarshipModel scholarModel = ScholarshipModel(
                              firstName: document['firstName'],
                              lastName: document['lastName'],
                              about: document['about'],
                              address: document['address'],
                              educationLevel: document['educationLevel'],
                              scholarship: document['scholarship'],
                              Description: document['Description'],
                              status: document['status'],
                              DOB: document['DOB'],
                              NGOUID: document['NGOUID'],
                              contact: document['contact'] ?? "");
                          // commit changes for git

                          return GestureDetector(
                            //You need to make my child interactive
                            /*  onTap: () =>
                                    Get.to(() => SingleVehicleDetailsScreen(
                                          carsModel: carsModel,
                                        )),*/
                            child: ScholarshipCard(
                              onAccept: () {
                                FirebaseFirestore.instance
                                    .collection('scholarshipRequest')
                                    .doc(document.id)
                                    .update({'status': 'accepted'});
                                // Handle accept action
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Accepted')),
                                );
                              },
                              onReject: () {
                                FirebaseFirestore.instance
                                    .collection('scholarshipRequest')
                                    .doc(document.id)
                                    .update({'status': 'rejected'});
                                // Handle reject action
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Rejected')),
                                );
                              },
                              s: scholarModel,
                            ),
                          );
                        }, //item Builder
                      ));
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScholarshipCard extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final ScholarshipModel s;

  const ScholarshipCard({
    required this.onAccept,
    required this.onReject,
    required this.s,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.firstName + s.lastName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tagline',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBtn(
                  height: 35,
                  width: 120,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicantDetailsPage(
                          about: s.about,
                          firstName: s.firstName,
                          lastName: s.lastName,
                          address: s.address,
                          educationLevel: s.educationLevel,
                          selectedScholarship: s.scholarship,
                          experience: s.Description,
                          contact: s.contact,
                        ),
                      ),
                    );
                  },
                  text: 'View Details',
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: onAccept,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: onReject,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
