import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unity_uplift/NGO/models/drawer.dart';
import 'package:unity_uplift/NGO/utils/app_colors.dart';

class DonorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('DonationToStudent')
              .snapshots(),
          //FirebaseFirestore.instance.collection('categories').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                    Donor donationToStudent = Donor(
                      name: document['donorName'],
                      amount: document['donationAmount'],
                      contact: document['donorContact'],
                      email: document['donorEmail'],
                      beneficiary: document['studentName'],
                    );
                    // commit changes for git

                    return GestureDetector(
                      child: DonorCard(
                        donor: donationToStudent,
                      ),
                    );
                  }, //item Builder
                ));
            return Container();
          },
        ),
      ),
    );
  }
}

class Donor {
  final String name;
  final String amount;
  final String contact;
  final String email;
  final String beneficiary;

  Donor({
    required this.name,
    required this.amount,
    required this.contact,
    required this.email,
    required this.beneficiary,
  });
}

class DonorCard extends StatelessWidget {
  final Donor donor;

  const DonorCard({Key? key, required this.donor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: AppColors.primaryColor,
      shadowColor: Colors.grey.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ApplyForScholarshipPage(),
          //   ),
          // );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                donor.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount: \$${donor.amount}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const SizedBox(width: 80), // Spacer for alignment
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Contact: ${donor.contact}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Email: ${donor.email}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Beneficiaries:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'beneficiary: ${donor.beneficiary}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryColor,
                ),
              ),
              /*Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: donor.beneficiaries.map((beneficiary) {
                  return Text(
                    '- $beneficiary',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryColor,
                    ),
                  );
                }).toList(),
              ),*/
              const SizedBox(height: 8),
              /*Align(
                alignment: Alignment.centerLeft,
                child: CustomBtn(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ApplyForScholarshipPage(),
                    //   ),
                    // );
                  },
                  color: AppColors.secondaryColor,
                  textColor: AppColors.primaryColor,
                  height: 30,
                  width: 80,
                  text: 'View',
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
