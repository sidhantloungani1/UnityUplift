// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class ScholarshipListModel {
  final String scholarshipTitle;
  final String NGOName;
  final String eligibilityCriteria;
  final String educationLevel;
  final String scholarshipType;
  final String scholarshipDescription;
  final String NGOUID;
  final Timestamp expirydate;

  ScholarshipListModel(
      {required this.scholarshipTitle,
      required this.NGOName,
      required this.eligibilityCriteria,
      required this.educationLevel,
      required this.scholarshipType,
      required this.scholarshipDescription,
      required this.NGOUID,
      required this.expirydate});

  // Serialize the UserModel instance to a JSON map// for saving data to the0
  // .database...map model to Json
  Map<String, dynamic> toMap() {
    return {
      'scholarshipTitle': scholarshipTitle,
      'NGOName': NGOName,
      'eligibilityCriteria': eligibilityCriteria,
      'educationLevel': educationLevel,
      'scholarshipType': scholarshipType,
      'scholarshipDescription': scholarshipDescription,
      'NGOUID': NGOUID,
      'ExpiryDate': expirydate
    };
  }

  // Create a UserModel instance from a JSON map// For getting data from database and map JSON to model
  factory ScholarshipListModel.fromMap(Map<String, dynamic> json) {
    return ScholarshipListModel(
        scholarshipTitle: json['scholarshipTitle'],
        NGOName: json['NGOName'],
        eligibilityCriteria: json['eligibilityCriteria'],
        educationLevel: json['educationLevel'],
        scholarshipType: json['scholarshipType'],
        scholarshipDescription: json['scholarshipDescription'],
        NGOUID: json['NGOUID'],
        expirydate: json['ExpiryDate']);
  }
}
