import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseFirestoreDatabase {
  static final firestoreDatabase = FirebaseFirestore.instance;
  Future<void> createCollection(
      String id, String uid, String collectionName, Map<String, dynamic> data);
  Future editCollection(
      String id, String uid, String collectionName, Map<String, dynamic> data);
 
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocData(
    String id,
    String uid,
    String collectionName,
  );
  Future<QuerySnapshot<Map<String, dynamic>>> getCollection(
    String uid,
    String collectionName,
  );
}
