import 'package:flutter/material.dart';
import 'package:unity_uplift/components/custom_btn.dart';
import 'package:unity_uplift/NGO/screens/process_complete_msg.dart';

class viewscholarship extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Handle profile icon click
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const ScholarshipDetailSection(
              label: 'Scholarship Title',
              value: 'XYZ Scholarship',
            ),
            const ScholarshipDetailSection(
              label: 'Provider',
              value: 'XYZ Organization',
            ),
            const ScholarshipDetailSection(
              label: 'Application Deadline',
              value: 'February 28, 2023',
            ),
            const ScholarshipDetailSection(
              label: 'Eligibility Criteria',
              value:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            ),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ScholarshipTagButton(icon: Icons.school, label: 'Education'),
                ScholarshipTagButton(icon: Icons.group, label: 'Community'),
                ScholarshipTagButton(icon: Icons.star, label: 'Merit-Based'),
                ScholarshipTagButton(icon: Icons.language, label: 'Language'),
                ScholarshipTagButton(
                    icon: Icons.sports_soccer, label: 'Sports'),
              ],
            ),
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.center,
              child: CustomBtn(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const process_complete(),
                    ),
                  );
                },
                height: 60,
                width: 400.0,
                text: 'Apply Next',
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class ScholarshipDetailSection extends StatelessWidget {
  final String label;
  final String value;

  const ScholarshipDetailSection({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class ScholarshipTagButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ScholarshipTagButton({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle tag button click
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
