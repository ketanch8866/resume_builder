import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/app_routes/app_routes_name.dart';
import 'package:resume_builder/data/auth/authentication.dart';
import 'package:resume_builder/res/app_const.dart';

class AuthController extends GetxController {
  final Authentication _auth = Authentication();
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> cPasswordController = TextEditingController().obs;
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode cPasswordFocusNode = FocusNode();
  RegExp emailIdValidation = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
  RxString _emailError = "".obs;
  RxString get emailError => _emailError;
  RxString _passwordError = "".obs;
  RxString get passwordError => _passwordError;
  RxBool _passwordVisibilities = false.obs;
  RxBool get passwordVisibilities => _passwordVisibilities;
  RxString _cPasswordError = "".obs;
  RxString get cPasswordError => _cPasswordError;
  RxBool _cPasswordVisibilities = false.obs;
  RxBool get cPasswordVisibilities => _cPasswordVisibilities;
  Rx<Status> _status = Status.complited.obs;
  Rx<Status> get status => _status;
  setStatus(Status sta) {
    _status.value = sta;
  }
  setEmailError(String error) {
    _emailError.value = error;
  }

  void setPasswordVisibilities() {
    _passwordVisibilities.value = !_passwordVisibilities.value;
  }

  void setCPasswordVisibilities() {
    _cPasswordVisibilities.value = !_passwordVisibilities.value;
  }

  setPasswordError(String error) {
    _emailError.value = error;
  }

  signIn() async {
    try {
      setStatus(Status.loading);
      await _auth
          .loginToUserWithEmailAndPassword(
              emailController.value.text, passwordController.value.text)
          .then((value) {
        setStatus(Status.complited);
        print("login user ${value!.displayName}");
        if(value!=null){cleanUp();
          Get.offAllNamed(AppRoutesName.homeRoutes);
        }
      });

    } catch (e) {
      setStatus(Status.complited);
      throw e;
    }
  }

  signUp() async {
    try {  setStatus(Status.loading);
      await _auth
          .createUserWithEmailAndPassword(
              emailController.value.text, passwordController.value.text,nameController.value.text)
          .then((value) {  setStatus(Status.complited);
        if(value!=null){
          cleanUp();
          Get.offAllNamed(AppRoutesName.homeRoutes);
        }
      });
    } catch (e) {  setStatus(Status.complited);
      throw e;
    }
  }
  cleanUp(){
    emailController.value.text = "";
    passwordController.value.text = "";
    cPasswordController.value.text = "";
    nameController.value.text = "";
  }
}
