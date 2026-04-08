import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../main_screens/home_screen.dart';
import '../widgets/simple_app_bar.dart';

class Approvestatus extends StatefulWidget {
  const Approvestatus({Key? key}) : super(key: key);

  @override
  State<Approvestatus> createState() => _AllVerifiedSellersScreenState();
}

class _AllVerifiedSellersScreenState extends State<Approvestatus> {
  QuerySnapshot? allSellers;

  displayDialogBoxForBlockingAccount(userDocumentID) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Block Account",
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              "Do you want to block this account?",
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
                    "status": "not approved",
                  };

                  FirebaseFirestore.instance
                      .collection("scholarshipRequest")
                      .doc(userDocumentID)
                      .update(userDataMap)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const HomeScreen()));

                    SnackBar snackBar = const SnackBar(
                      content: Text(
                        "Blocked Successfully.",
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
        });
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("scholarshipRequest")
        .where("status", isEqualTo: "accepted")
        .get()
        .then((allVerifiedUsers) {
      setState(() {
        allSellers = allVerifiedUsers;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget displayVerifiedSellersDesign() {
      if (allSellers != null) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: allSellers!.docs.length,
          itemBuilder: (context, i) {
            return Card(
              color: const Color(0xFF4350AF),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        child: Text(
                          allSellers!.docs[i].get("firstName")[0],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      title: Text(
                        allSellers!.docs[i].get("firstName"),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        allSellers!.docs[i].get("scholarship"),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            allSellers!.docs[i].get("status"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.person_pin_sharp,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      label: Text(
                        "Block this Account".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                          letterSpacing: 3,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        displayDialogBoxForBlockingAccount(
                            allSellers!.docs[i].id);
                      },
                    ),
                  ),
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
        title: "All Verified Sellers Accounts",
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .5,
          child: displayVerifiedSellersDesign(),
        ),
      ),
    );
  }
}
