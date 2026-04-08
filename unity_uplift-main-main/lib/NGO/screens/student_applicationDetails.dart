import 'package:flutter/material.dart';
import 'package:unity_uplift/NGO/utils/app_colors.dart';
import 'package:unity_uplift/components/custom_btn.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicantDetailsPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String about;
  final String address;
  final String educationLevel;
  final String selectedScholarship;
  final String experience;
  final String contact;

  ApplicantDetailsPage(
      {required this.firstName,
      required this.lastName,
      required this.about,
      required this.address,
      required this.educationLevel,
      required this.selectedScholarship,
      required this.experience,
      required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applicant Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailSection('Name', '$firstName $lastName'),
            _buildDivider(),
            _buildDetailSection('About', about),
            _buildDivider(),
            _buildDetailSection('Address', address),
            _buildDivider(),
            _buildDetailSection('Education Level', educationLevel),
            _buildDivider(),
            _buildDetailSection('Selected Scholarship', selectedScholarship),
            _buildDivider(),
            _buildDetailSection('Experience', experience),
            const SizedBox(height: 20),
            Center(
              child: CustomBtn(
                onPressed: () {
                  final Uri smsLaunchUri = Uri(
                    scheme: 'tel',
                    path: contact,
                  );
                  launchUrl(smsLaunchUri);
                },
                color: AppColors.primaryColor,
                textColor: AppColors.secondaryColor,
                height: 50,
                width: 150,
                text: 'Contact Us',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String heading, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            detail,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(),
    );
  }
}
