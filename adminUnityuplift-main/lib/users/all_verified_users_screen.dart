import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../main_screens/home_screen.dart';
import '../widgets/simple_app_bar.dart';

class AllVerifiedUsersScreen extends StatefulWidget {
  const AllVerifiedUsersScreen({Key? key}) : super(key: key);

  @override
  State<AllVerifiedUsersScreen> createState() => _AllVerifiedUsersScreenState();
}

class _AllVerifiedUsersScreenState extends State<AllVerifiedUsersScreen> {
  QuerySnapshot? allUsers;

  displayDialogBoxForBlockingAccount(String userDocumentID) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Block Account",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Do you want to block this account?",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
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
                    .collection("Student")
                    .doc(userDocumentID)
                    .update(userDataMap)
                    .then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (c) => const HomeScreen()),
                  );

                  const snackBar = SnackBar(
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
      },
    );
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("Student")
        .where("status", isEqualTo: "approved")
        .get()
        .then((allVerifiedUsers) {
      setState(() {
        allUsers = allVerifiedUsers;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget displayVerifiedUsersDesign() {
      if (allUsers != null) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: allUsers!.docs.length,
          itemBuilder: (context, i) {
            return Card(
              color: const Color(0xFF4350AF),
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      leading: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        child: Text(
                          allUsers!.docs[i].get("studentName")[0],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      // leading: CircleAvatar(
                      //   radius: 32.5,
                      //   backgroundImage: NetworkImage(
                      //     allUsers!.docs[i].get("sellerImage"),
                      //   ),
                      //   onBackgroundImageError: (exception, stackTrace) {
                      //     // Handle image loading error
                      //   },
                      //   child: allUsers!.docs[i].get("sellerImage") == null ||
                      //           allUsers!.docs[i].get("sellerImage").isEmpty
                      //       ? const Icon(Icons.person, size: 32.5)
                      //       : null,
                      // ),
                      title: Text(
                        allUsers!.docs[i].get("studentName"),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      subtitle: Text(
                        allUsers!.docs[i].get("email"),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const Divider(color: Color.fromARGB(255, 233, 233, 233)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        icon: const Icon(
                          Icons.person_pin_sharp,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        label: Text(
                          "Block this Account".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        onPressed: () {
                          displayDialogBoxForBlockingAccount(
                            allUsers!.docs[i].id,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return const Center(
          child: Text(
            "No Record Found.",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: SimpleAppBar(
        title: "All Verified Users Accounts",
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: displayVerifiedUsersDesign(),
        ),
      ),
    );
  }
}
