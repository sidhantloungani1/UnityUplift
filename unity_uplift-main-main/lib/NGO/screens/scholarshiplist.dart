import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_uplift/NGO/screens/dashboard/dashboard_org.dart';
import 'package:unity_uplift/NGO/screens/post_scholarship.dart';
import 'package:unity_uplift/NGO/screens/update_post_scholarship.dart';
import 'package:unity_uplift/components/custom_btn.dart';
import '../models/scholarshipList_model.dart';

class ScholarshipList extends StatefulWidget {
  const ScholarshipList({Key? key}) : super(key: key);

  @override
  _ScholarshipListState createState() => _ScholarshipListState();
}

class _ScholarshipListState extends State<ScholarshipList> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  Future deleteData(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("AvailableScholarships")
          .doc(id)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(const dashboard_NGO());
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
            child: CustomBtn(
              onPressed: () {
                Get.to(const postscholarship());
              },
              height: 60,
              width: 150.0,
              text: 'Add Scholarship',
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Search scholarships",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              onChanged: _onSearchTextChanged,
              decoration: const InputDecoration(
                labelText: 'search',
                hintText: "Search Here",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('AvailableScholarships')
                  .where('NGOUID', isEqualTo: user.uid.toString())
                  .where('ExpiryDate', isGreaterThan: Timestamp.now())
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 50,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                List<DocumentSnapshot> documents = snapshot.data!.docs;

                if (_searchQuery.isNotEmpty) {
                  documents = documents.where((doc) {
                    final title =
                        doc['scholarshipTitle'].toString().toLowerCase();
                    final tagline =
                        doc['scholarshipType'].toString().toLowerCase();
                    final searchLower = _searchQuery.toLowerCase();
                    return title.contains(searchLower) ||
                        tagline.contains(searchLower);
                  }).toList();
                }

                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot document = documents[index];
                      ScholarshipListModel scholarshiplistModel =
                          ScholarshipListModel(
                        scholarshipTitle: document['scholarshipTitle'],
                        NGOName: document['NGOName'],
                        eligibilityCriteria: document['eligibilityCriteria'],
                        educationLevel: document['educationLevel'],
                        scholarshipType: document['scholarshipType'],
                        scholarshipDescription:
                            document['scholarshipDescription'],
                        NGOUID: document['NGOUID'],
                        expirydate: document['ExpiryDate'],
                      );
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color.fromARGB(255, 211, 211, 211),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  scholarshiplistModel.scholarshipTitle,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  scholarshiplistModel.scholarshipType,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF4350AF),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      deleteData(document.id.toString());
                                    },
                                    icon:
                                        const Icon(Icons.delete_outline_sharp),
                                    color: const Color(0xff4350AF),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.to(() => Updatepostscholarship(
                                            id: document.id,
                                            scholarship_model:
                                                scholarshiplistModel,
                                          ));
                                    },
                                    icon: const Icon(Icons.edit),
                                    color: const Color(0xff4350AF),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onSearchTextChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }
}
