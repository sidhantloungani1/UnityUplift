import 'package:flutter/material.dart';
import 'package:student/utils/app_colors.dart';

class ScholarshipHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Scholarship History'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Scholarship History',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          
          Expanded(
            
            child: ListView(
              padding: EdgeInsets.all(16),
              
              children: [
                buildScholarshipCard(
                  'Merit Scholarship',
                  'John Doe',
                  'Computer Science Program',
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque nec diam nec urna accumsan lacinia.',
                  '\$5000',
                ),
                SizedBox(height: 16),
                buildScholarshipCard(
                  'STEM Excellence Award',
                  'Jane Smith',
                  'Mechanical Engineering Program',
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque nec diam nec urna accumsan lacinia.',
                  '\$7000',
                ),
                SizedBox(height: 16),
                buildScholarshipCard(
                  'Artistic Achievement Grant',
                  'Alex Johnson',
                  'Fine Arts Program',
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque nec diam nec urna accumsan lacinia.',
                  '\$4500',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScholarshipCard(String scholarshipName, String receiver, String program, String details, String awardAmount) {
    return Card(
      elevation: 5,
      color: AppColors.primaryColor, 
      shadowColor: Colors.grey.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scholarshipName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Receiver: $receiver',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Program: $program',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Details: $details',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Award Amount: $awardAmount',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
