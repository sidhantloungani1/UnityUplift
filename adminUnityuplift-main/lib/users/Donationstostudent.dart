import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../main_screens/home_screen.dart';
import '../widgets/simple_app_bar.dart';

class Donationstostudent extends StatefulWidget {
  const Donationstostudent({Key? key}) : super(key: key);

  @override
  State<Donationstostudent> createState() => _DonationstostudentState();
}

class _DonationstostudentState extends State<Donationstostudent> {
  QuerySnapshot? allSellers;

  displayDialogBoxForActivatingAccount(userDocumentID) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Activate Account",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Do you want to activate this account?",
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> userDataMap = {
                  "status": "approved",
                };

                FirebaseFirestore.instance
                    .collection("DonationsToStudent")
                    .doc(userDocumentID)
                    .update(userDataMap)
                    .then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const HomeScreen()));

                  const snackBar = SnackBar(
                    content: Text(
                      "Activated Successfully.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.cyan,
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("DonationToStudent")
        .get()
        .then((allVerifiedUsers) {
      setState(() {
        allSellers = allVerifiedUsers;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget displayBlockedSellersDesign() {
      if (allSellers != null) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: allSellers!.docs.length,
          itemBuilder: (context, i) {
            return Card(
              elevation: 10,
              color: const Color(0xFF4350AF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          allSellers!.docs[i].get("CourseName")[0],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        allSellers!.docs[i].get("CourseName"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Donor: ${allSellers!.docs[i].get("donorName")}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Email: ${allSellers!.docs[i].get("donorEmail")}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Amount: ${allSellers!.docs[i].get("donationAmount")}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Student: ${allSellers!.docs[i].get("studentName")}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Institute: ${allSellers!.docs[i].get("InstituteName")}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // Handle the email button press
                        },
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: ElevatedButton.icon(
                  //     style: ElevatedButton.styleFrom(
                  //       primary: Colors.green,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       padding: const EdgeInsets.symmetric(
                  //         vertical: 12,
                  //         horizontal: 24,
                  //       ),
                  //     ),
                  //     icon: const Icon(
                  //       Icons.person_pin_sharp,
                  //       color: Colors.white,
                  //     ),
                  //     label: Text(
                  //       "Activate this Account".toUpperCase(),
                  //       style: const TextStyle(
                  //         fontSize: 15,
                  //         color: Colors.white,
                  //         letterSpacing: 1,
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       displayDialogBoxForActivatingAccount(
                  //           allSellers!.docs[i].id);
                  //     },
                  //   ),
                  // ),
                ],
              ),
            );
          },
        );
      } else {
        return const Center(
          child: Text(
            "No Record Found.",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: SimpleAppBar(
        title: "All Blocked Sellers Accounts",
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .75,
          child: displayBlockedSellersDesign(),
        ),
      ),
    );
  }
}
