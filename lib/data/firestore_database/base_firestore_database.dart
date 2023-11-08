import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseFirestoreDatabase {
  static final firestoreDatabase = FirebaseFirestore.instance;
  Future<void> createCollection(
      String uid, String collectionName, Map<String, dynamic> data);
  Future editCollection(
      String uid, String collectionName, Map<String, dynamic> data);
  Stream get getCollection;
}
