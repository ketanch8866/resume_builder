import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:resume_builder/app_routes/app_routes_name.dart';
import 'package:resume_builder/res/app_const.dart';
import 'package:resume_builder/res/app_text_style/app_text_style.dart';
import 'package:resume_builder/res/custom_widgets/custom_button.dart';
import 'package:resume_builder/res/custom_widgets/custom_sizedbox.dart';
import 'package:resume_builder/res/custom_widgets/custom_textfield.dart';
import 'package:resume_builder/res/theam/app_colors.dart';
import 'package:resume_builder/screens/auth/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Sign In",
            style: AppTextStyle.largeTitleBlack,
          ),
          Obx(
            () => Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                constraints: const BoxConstraints(
                  maxWidth: 400.0, // Set the maximum width you desire
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: authController.emailController.value,
                        prefixIcon: Icons.email,
                        errorText: authController.emailError.value,
                        hintText: "Enter Email",
                        textInputType: TextInputType.emailAddress,
                        currentFocusNode: authController.emailFocusNode,
                        nextFocusNode: authController.passwordFocusNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "this field is required";
                          } else if (!validator.email(value)) {
                            return "Invalid Email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomSizedBox.sizedBoxHeight(10),
                      CustomPasswordTextField(
                        controller: authController.passwordController.value,
                        errorText: authController.passwordError.value,
                        hintText: "Enter password",
                        obsecureVisibility:
                            authController.passwordVisibilities.value,
                        prefixIcon: Icons.password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "this field is required";
                          } else if (validator.password(value)) {
                            return "Invalid password";
                          } else {
                            return null;
                          }
                        },
                        currentFocusNode: authController.passwordFocusNode,
                        visibility: () {
                          authController.setPasswordVisibilities();
                        },
                      ),
                      CustomSizedBox.sizedBoxHeight(10),
                      CustomButton(
                        title: "Sign In",
                        loading:authController.status.value == Status.loading ,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authController.signIn();
                          }
                        },
                      ),
                      Row(
                        children: [
                          Text("don't have an account "),
                          TextButton(
                              onPressed: () {
                                Get.toNamed(AppRoutesName.signUpRoutes);
                              },
                              child: Text(
                                "Sign Up",
                                style: AppTextStyle.normalTitleText
                                    .copyWith(color: AppColors.primaryColor),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
