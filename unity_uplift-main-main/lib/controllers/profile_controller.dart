import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unity_uplift/NGO/services/firebase_service.dart';

class ProfileController extends FirebaseService {
  ProfileController(super.collectionPath);

  @override
  Future<DocumentSnapshot<Object?>> get(String documentId) {
    return super.get(documentId);
  }
}
