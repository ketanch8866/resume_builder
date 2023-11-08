import 'package:firebase_auth/firebase_auth.dart';
import 'package:resume_builder/model/user_model.dart';

abstract class BaseAuthenticatiopn {
  static final firebaseAuth = FirebaseAuth.instance;
  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password, String name);
  Future<UserModel?> loginToUserWithEmailAndPassword(
      String email, String password);
}
