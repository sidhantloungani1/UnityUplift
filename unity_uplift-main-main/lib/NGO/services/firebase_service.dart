import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference _collectionReference;

  FirebaseService(String collectionPath)
      : _collectionReference =
            FirebaseFirestore.instance.collection(collectionPath);

  Future<DocumentSnapshot> get(String documentId) {
    return _collectionReference.doc(documentId).get();
  }

  Future<void> put(String documentId, Map<String, dynamic> data) {
    return _collectionReference.doc(documentId).set(data);
  }

  Future<void> delete(String documentId) {
    return _collectionReference.doc(documentId).delete();
  }

  Future<void> post<T>(Map<String, dynamic> data) {
    return _collectionReference.add(data);
  }
}
