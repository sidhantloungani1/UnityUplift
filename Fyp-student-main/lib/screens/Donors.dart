import 'package:flutter/material.dart';
import 'package:student/screens/apply.dart';
import 'package:student/utils/app_colors.dart';

import '../../components/custom_btn.dart';
import 'drawer_widget.dart';

class DonorsScreen extends StatelessWidget {
  final List<Donor> donors = [
    Donor(
      name: 'Syed Ali',
      amount: 5000,
      location: 'ABC',
      email: 'syedali@gmail.com',
      beneficiaries: ['Student X'],
    ),
    Donor(
      name: 'Muhammad',
      amount: 10000,
      location: 'XYZ',
      email: 'muhammad@gmail.com',
      beneficiaries: ['Student Y'],
    ),
    Donor(
      name: 'Safwan',
      amount: 10000,
      location: 'XYZ',
      email: 'Safwan@gmail.com',
      beneficiaries: ['Student Y'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: studentDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: donors.length,
          itemBuilder: (context, index) {
            return DonorCard(donor: donors[index]);
          },
        ),
      ),
    );
  }
}

class Donor {
  final String name;
  final int amount;
  final String location;
  final String email;
  final List<String> beneficiaries;

  Donor({
    required this.name,
    required this.amount,
    required this.location,
    required this.email,
    required this.beneficiaries,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ApplyForScholarshipPage(),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(16),
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
              SizedBox(height: 8),
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
                  SizedBox(width: 80), // Spacer for alignment
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Location: ${donor.location}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Email: ${donor.email}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Beneficiaries:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: donor.beneficiaries.map((beneficiary) {
                  return Text(
                    '- $beneficiary',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryColor,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomBtn(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplyForScholarshipPage(),
                      ),
                    );
                  },
                  color: AppColors.secondaryColor,
                  textColor: AppColors.primaryColor,
                  height: 30,
                  width: 80,
                  text: 'View',
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
