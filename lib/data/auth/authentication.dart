import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:resume_builder/app_exception/app_exception.dart';
import 'package:resume_builder/data/auth/base_auth.dart';
import 'package:resume_builder/data/firestore_database/base_firestore_database.dart';
import 'package:resume_builder/model/user_model.dart';
import 'package:resume_builder/res/app_const.dart';
import 'package:resume_builder/res/utils.dart';

class Authentication extends BaseAuthenticatiopn {
  UserModel? userModel;
  @override
  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await BaseAuthenticatiopn.firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if(userCredential!=null){
        User? user = userCredential.user;

        userModel = UserModel(
            displayName: name,
            uid: user!.uid,
            email: email,
            cretedTime: DateTime.now());
        await BaseFirestoreDatabase.firestoreDatabase
            .collection('users')
            .doc(user.uid)
            .set(userModel!.toJson());
      }

      return userModel!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      throw e;
    } catch (e) {
      print(e);
      throw e;
    }
    // return null;
  }

  @override
  Future<UserModel> loginToUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          User? user = userCredential.user;
      var userData  = await BaseFirestoreDatabase.firestoreDatabase
          .collection('users')
          .doc(user!.uid).get();
      if(userData.exists) {
        userModel = UserModel.fromJson(userData.data()!);
        return userModel!;
      }else{
        throw FetchDataException;
      }

    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      Utils.showScanckBar(message: e.code, toastType: ToastType.error);
      throw e.code;
    }catch(e){
      throw e;
    }
    // return null;
  }

  @override
  Future<void> signout()async{
try{
  await BaseAuthenticatiopn.firebaseAuth.signOut();
}catch(e){
  print(e.toString());
  throw e;
}
  }
}
