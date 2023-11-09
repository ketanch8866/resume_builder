import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resume_builder/data/firestore_database/base_firestore_database.dart';

class HandleFireStoreDataBase extends BaseFirestoreDatabase {
  @override
  Future<void> createCollection(String id, String uid, String collectionName,
      Map<String, dynamic> data) async {
    try {
      await BaseFirestoreDatabase.firestoreDatabase
          .collection(collectionName)
          .doc(id)
          .set(data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future editCollection(String id, String uid, String collectionName,
      Map<String, dynamic> data) async {
    try {
      await BaseFirestoreDatabase.firestoreDatabase
          .collection(collectionName)
          .doc(id)
          .update(data);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocData(
    String id,
    String uid,
    String collectionName,
  ) async {
    try {
      return await BaseFirestoreDatabase.firestoreDatabase
          .collection(collectionName)
          .doc(id)
          .get();
      // .then((DocumentSnapshot documentSnapshot) {
      //   if (documentSnapshot.exists) {
      //     print('Document data: ${documentSnapshot.data()}');
      //   } else {
      //     print('Document does not exist on the database');
      //   }
      // });
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getCollection(
      String uid, String collectionName) async {
    try {
      return await BaseFirestoreDatabase.firestoreDatabase
          .collection(collectionName)
          .where('uid', isEqualTo: uid)
          .get();
    } catch (e) {
      throw e;
    }
  }
}
