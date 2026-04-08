import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student/screens/Dashboard.dart';
import 'package:student/screens/singleScholarshipDetails.dart';
import 'package:student/utils/app_colors.dart';

import '../../components/custom_btn.dart';
import '../models/scholarshipList_model.dart';
import 'applyScholarship.dart';
import 'drawer_widget.dart';

class ScholarshipProgramsScreen extends StatefulWidget {
  const ScholarshipProgramsScreen({Key? key}) : super(key: key);

  @override
  State<ScholarshipProgramsScreen> createState() =>
      _ScholarshipProgramsScreenState();
}

class _ScholarshipProgramsScreenState extends State<ScholarshipProgramsScreen> {
  String? educationLevel;
  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    educationLevel = prefs.getString('educationLevel');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scholarship Programs"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //  Navigator.of(context).pop();
            Get.to(DashboardScreen());
          },
        ),
      ),
      endDrawer: studentDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scholarship Programs',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Search
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search for scholarships...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              /* child: ListView(
                children: [
                  ScholarshipCard(),
                  const SizedBox(height: 16),
                  ScholarshipCard(),
                  const SizedBox(height: 16),
                  ScholarshipCard(),
                  const SizedBox(height: 16),
                  ScholarshipCard(),
                  const SizedBox(height: 16),
                  ScholarshipCard(),
                  // Add more ScholarshipCard widgets as needed
                ],
              ),*/
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('AvailableScholarships')
                    .where('educationLevel', isEqualTo: educationLevel)
                    .where('ExpiryDate', isGreaterThan: Timestamp.now())
                    .snapshots(),
                //FirebaseFirestore.instance.collection('categories').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
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
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document = documents[index];

                          ScholarshipListModel scholarModel =
                              ScholarshipListModel(
                            scholarshipTitle: document['scholarshipTitle'],
                            NGOName: document['NGOName'],
                            eligibilityCriteria:
                                document['eligibilityCriteria'],
                            educationLevel: document['educationLevel'],
                            scholarshipType: document['scholarshipType'],
                            scholarshipDescription:
                                document['scholarshipDescription'],
                            NGOUID: document['NGOUID'],
                            ExpiryDate: document['ExpiryDate'],
                          );
                          // commit changes for git

                          return GestureDetector(
                            //You need to make my child interactive
                            /*  onTap: () =>
                                    Get.to(() => SingleVehicleDetailsScreen(
                                          carsModel: carsModel,
                                        )),*/
                            child: ScholarshipCard(
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
  final ScholarshipListModel s;

  const ScholarshipCard({
    required this.s,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 250, 250, 250),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 25, 24, 24).withOpacity(0.3),
              offset: const Offset(0, 1),
            ),
          ],
          border: Border.all(color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scholarship : ' + s.scholarshipTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Provider: ' + s.NGOName,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBtn(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplyForScholarshipPage1(
                            scholarshipName: s.scholarshipTitle,
                            NGOUID: s.NGOUID),
                      ),
                    );
                  },
                  color: AppColors.primaryColor,
                  textColor: AppColors.secondaryColor,
                  height: 35,
                  width: 100.0,
                  text: 'Apply',
                  fontSize: 14,
                ),
                const SizedBox(width: 8),
                CustomBtn(
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => singleScholarshipDetails(
                            scholarshipName: s.scholarshipTitle,
                            NGOUID: s.NGOUID),
                      ),
                    );*/
                    Get.to(() => singleScholarshipDetails(s: s));
                  },
                  color: Color.fromARGB(255, 230, 229, 229),
                  textColor: AppColors.primaryColor,
                  height: 35,
                  width: 100.0,
                  text: 'View Details',
                  fontSize: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
