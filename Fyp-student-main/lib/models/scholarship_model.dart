// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class ScholarshipModel {
  final String firstName;
  final String lastName;
  final String about;
  final String address;
  final String educationLevel;
  final String scholarship;
  final String Description;
  final String status;
  final Timestamp DOB;
  final String NGOUID;

  ScholarshipModel(
      {required this.firstName,
      required this.lastName,
      required this.about,
      required this.address,
      required this.educationLevel,
      required this.scholarship,
      required this.Description,
      required this.status,
      required this.DOB,
      required this.NGOUID});

  // Serialize the UserModel instance to a JSON map// for saving data to the database...map model to Json
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'about': about,
      'address': address,
      'educationalLevel': educationLevel,
      'scholarship': scholarship,
      'Description': Description,
      'status': status,
      'DOB': DOB,
      'NGOUID': NGOUID,
    };
  }

  // Create a UserModel instance from a JSON map// For getting data from database and map JSON to model
  factory ScholarshipModel.fromMap(Map<String, dynamic> json) {
    return ScholarshipModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      about: json['about'],
      address: json['address'],
      educationLevel: json['educationLevel'],
      scholarship: json['scholarship'],
      Description: json['Description'],
      status: json['status'],
      DOB: json['DOB'],
      NGOUID: json['NGOUID'],
    );
  }
}
