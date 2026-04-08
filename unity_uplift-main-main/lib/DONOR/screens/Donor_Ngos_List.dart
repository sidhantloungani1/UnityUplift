import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unity_uplift/DONOR/screens/payment_module/payment_gateway.dart';
import 'package:unity_uplift/NGO/utils/app_colors.dart';
import 'package:unity_uplift/components/custom_btn.dart';

import '../models/drawer_donor.dart';

class Donor_ngolist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: donor_Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'NGO LIST',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // New Search Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                    spreadRadius: 0.5,
                    blurRadius: 20,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search for NGO...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              /*child: ListView(
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
                stream:
                    FirebaseFirestore.instance.collection('NGO').snapshots(),
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

                          Ngo ngoObject = Ngo(
                            organizationName: document['organizationName'],
                            missionAndObjectives:
                                document['missionAndObjectives'],
                            address: document['address'],
                          );
                          // commit changes for git

                          return GestureDetector(
                            child: ScholarshipCard(
                              ngo: ngoObject,
                            ),
                          );
                        }, //item Builder
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Ngo {
  final String organizationName;
  final String missionAndObjectives;
  final String address;

  Ngo({
    required this.organizationName,
    required this.missionAndObjectives,
    required this.address,
  });
}

class ScholarshipCard extends StatelessWidget {
  final Ngo ngo;

  const ScholarshipCard({Key? key, required this.ngo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff384EB7),
        ),
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff384EB7).withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 20,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'NGO Name',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${ngo.organizationName}',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(width: 80), // Spacer for alignment
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Address',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                ' ${ngo.address}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 80), // Spacer for alignment
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBtn(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                },
                color: AppColors.primaryColor,
                textColor: AppColors.secondaryColor,
                height: 35,
                width: 100.0,
                text: 'Donate',
              ),
              const SizedBox(width: 8),
              /*   CustomBtn(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Donor_ngoDetails(),
                    ),
                  );
                },
                color: const Color.fromARGB(255, 230, 225, 225),
                textColor: AppColors.primaryColor,
                height: 35,
                width: 100.0,
                text: 'View Details',
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
