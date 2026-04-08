import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/screens/scholarshipStatusDetails.dart';

import '../components/custom_btn.dart';
import '../models/scholarship_model.dart';
import '../utils/app_colors.dart';
import 'drawer_widget.dart';

class ApplicationStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //test commit
      endDrawer: studentDrawerWidget(),
      /* ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Application Status',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          buildApplicationCard(
            context,
            'Scholarship Application 1',
            'In Progress',
            Colors.blue,
          ),
          const SizedBox(height: 24),
          buildApplicationCard(
            context,
            'Scholarship Application 2',
            'Accepted',
            Colors.green,
          ),
          const SizedBox(height: 24),
          buildApplicationCard(
            context,
            'Scholarship Application 3',
            'Rejected',
            Colors.red,
          ),
        ],
      ),*/
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('scholarshipRequest')
            .snapshots(),
        //FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  height: 5,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: documents.length,
                itemBuilder: (BuildContext context, int index) {
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
                  );

                  return GestureDetector(
                    //You need to make my child interactive
                    /*  onTap: () =>
                                    Get.to(() => SingleVehicleDetailsScreen(
                                          carsModel: carsModel,
                                        )),*/

                    child: buildApplicationCard(
                      context,
                      scholarModel,
                      scholarModel.scholarship,
                      scholarModel.status,
                      scholarModel.status == 'accepted'
                          ? Colors.green
                          : scholarModel.status == 'in progress'
                              ? Colors.yellow.shade700
                              : Colors.red,
                      // Colors.black45,
                    ),
                  );
                }, //item Builder
              ));
        },
      ),
    );
  }

  Widget buildApplicationCard(BuildContext context, ScholarshipModel s,
      String title, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 3,
        shadowColor: Color.fromARGB(255, 240, 240, 240).withOpacity(1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.black45)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    10.0, 5.0, 16.0, 40.0), // Increased bottom padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        title,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16), // Increased gap
                  ],
                ),
              ),
              // Positioned widget for the tag
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 8,
                child: CustomBtn(
                  onPressed: () {
                    Get.to(() => scholarshipStatusDetails(s: s));
                  },
                  color: AppColors.primaryColor,
                  textColor: AppColors.secondaryColor,
                  height: 35,
                  width: 100.0,
                  text: 'Details',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
