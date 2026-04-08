import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/drawer.dart';
import '../models/scholarshipList_model.dart';
import 'ViewDetails.dart';
import 'apply.dart';

class singleScholarshipDetails extends StatefulWidget {
  ScholarshipListModel s;
  singleScholarshipDetails({super.key, required this.s});

  //singleScholarshipDetails({Key? key, required this.s}) : super(key: key);
  /* const singleScholarshipDetails(
      {Key? key, required this.scholarshipName, required this.NGOUID})
      : super(key: key);
  final String scholarshipName;
  final  String NGOUID;*/

  @override
  State<singleScholarshipDetails> createState() =>
      _singleScholarshipDetailsState();
}

class _singleScholarshipDetailsState extends State<singleScholarshipDetails> {
  late String formattedDate;
  @override
  void initState() {
    formattedDate = DateFormat.yMMMEd().format(
        DateTime.fromMicrosecondsSinceEpoch(
            widget.s.ExpiryDate.microsecondsSinceEpoch));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: 200, // Adjust the height as needed
            //   decoration: const BoxDecoration(
            //       // image: DecorationImage(
            //       //   image: AssetImage('assets/images/logo.png'),
            //       //   fit: BoxFit.cover,
            //       // ),
            //       ),
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Scholarship Details",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ScholarshipDetailSection(
                    label: 'Scholarship Name',
                    value: widget.s.scholarshipTitle,
                  ),
                  ScholarshipDetailSection(
                    label: 'Provider',
                    value: widget.s.NGOName,
                  ),
                  ScholarshipDetailSection(
                    label: 'Education Level',
                    value: widget.s.educationLevel,
                  ),
                  ScholarshipDetailSection(
                    label: 'Eligibility Criteria',
                    value: widget.s.eligibilityCriteria,
                  ),
                  ScholarshipDetailSection(
                    label: 'Scholarship Description',
                    value: widget.s.scholarshipDescription,
                  ),
                  ScholarshipDetailSection(
                    label: 'Application Deadline',
                    value: formattedDate,
                  ),
                  ScholarshipDetailSection(
                    label: 'scholarshipType',
                    value: widget.s.scholarshipType,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            const Wrap(
              spacing: 8.0, // spacing b/w tags
              runSpacing: 10.0, // spsacing b/w lines
              children: [
                ScholarshipTagButton(icon: Icons.school, label: 'Education'),
                ScholarshipTagButton(icon: Icons.star, label: 'Merit-Based'),
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            // Align(
            //   alignment: Alignment.center,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const ApplyForScholarshipPage(),
            //         ),
            //       );
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.blue,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child:
            //         const Text("Apply", style: TextStyle(color: Colors.white)),
            //   ),
            // ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/*class ScholarshipDetailSection extends StatelessWidget {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.blue, size: 18),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: Colors.black, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}*/
