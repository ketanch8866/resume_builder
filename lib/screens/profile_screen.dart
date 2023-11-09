import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:resume_builder/res/app_text_style/app_text_style.dart';
import 'package:resume_builder/res/custom_widgets/custom_button.dart';
import 'package:resume_builder/res/custom_widgets/custom_sizedbox.dart';
import 'package:resume_builder/res/custom_widgets/custom_textfield.dart';
import 'package:resume_builder/res/theam/app_colors.dart';
import 'package:resume_builder/screens/view_model.dart/build_resume_controller.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final resumeBuildController = Get.find<BuildResumeController>();
    return Scaffold(
        body: Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 400.0, // Set the maximum width you desire
                ),
                padding: EdgeInsets.all(8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: resumeBuildController.nameController.value,
                        prefixIcon: Icons.person,
                        errorText: "",
                        hintText: "Enter Name",
                        textInputType: TextInputType.name,
                        currentFocusNode: resumeBuildController.nameFocusNode,
                        nextFocusNode: resumeBuildController.emailFocusNode,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomSizedBox.sizedBoxHeight(10),
                      CustomTextField(
                        controller: resumeBuildController.emailController.value,
                        prefixIcon: Icons.email,
                        errorText: "",
                        hintText: "Enter Email",
                        textInputType: TextInputType.emailAddress,
                        currentFocusNode: resumeBuildController.emailFocusNode,
                        nextFocusNode: resumeBuildController.mobileFocusNode,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "This field is required";
                          } else if (!validator.email(p0)) {
                            return "Invalid Email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomSizedBox.sizedBoxHeight(10),
                      CustomTextField(
                        controller:
                            resumeBuildController.mobileController.value,
                        prefixIcon: Icons.phone,
                        errorText: "",
                        hintText: "Enter Mobile number",
                        textInputType: TextInputType.phone,
                        currentFocusNode: resumeBuildController.mobileFocusNode,
                        nextFocusNode: resumeBuildController.linkFocusNode,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "This field is required";
                          } else if (!validator.phone(p0)) {
                            return "Invalid Mobile Number";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomSizedBox.sizedBoxHeight(10),
                      CustomTextField(
                        controller: resumeBuildController.linkController.value,
                        prefixIcon: Icons.link,
                        errorText: "",
                        hintText: "Enter LinkedIn Profile url",
                        textInputType: TextInputType.url,
                        currentFocusNode: resumeBuildController.linkFocusNode,
                        nextFocusNode: resumeBuildController.addressFocusNode,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "This field is required";
                          } else if (!validator.url(p0)) {
                            return "Invalid Url";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomSizedBox.sizedBoxHeight(10),
                      CustomTextField(
                        controller:
                            resumeBuildController.addressController.value,
                        prefixIcon: Icons.location_city,
                        errorText: "",
                        hintText: "Enter city name",
                        textInputType: TextInputType.text,
                        currentFocusNode:
                            resumeBuildController.addressFocusNode,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "This field is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomSizedBox.sizedBoxHeight(20),
                      CustomButton(
                        title: "Save Detail",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (resumeBuildController.isEdit.value) {
                              resumeBuildController.setEditedProfileData();
                            } else {
                              resumeBuildController.setProfileData();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
            physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: resumeBuildController.profileData.length,
              itemBuilder: (context, index) {
                return showProfileData(resumeBuildController, index);
              },
            )
          ],
        ),
      ),
    ));
  }

  Widget showProfileData(
      BuildResumeController resumeBuildController, int index) {
    return 
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            resumeBuildController.profileData[index].name,
            style: AppTextStyle.largeTitleBlack
                .copyWith(color: AppColors.primaryColor),
          ),
          const Divider(
            color: AppColors.primaryColor,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.greyColor),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: const Icon(Icons.phone,
                            color: AppColors.secondaryColor),
                        title: Text(
                          resumeBuildController.profileData[index].mobile,
                          maxLines: 1,overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.normalTitleText
                              .copyWith(color: AppColors.blackColor),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        leading: const Icon(
                          Icons.email,
                          color: AppColors.secondaryColor,
                        ),
                        title: Text(
                          resumeBuildController.profileData[index].email,
                          maxLines: 1,overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.normalTitleText
                              .copyWith(color: AppColors.blackColor),
                        ),
                      ),
                    )
                  ],
                ),
                //
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: const Icon(
                          Icons.link,
                          color: AppColors.secondaryColor,
                        ),
                        title: Text(
                          resumeBuildController.profileData[index].linkedInUrl,
                          maxLines: 1,overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.normalTitleText
                              .copyWith(color: AppColors.secondaryColor),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        leading: const Icon(
                          Icons.location_city,
                          color: AppColors.secondaryColor,
                        ),
                        title: Text(
                          resumeBuildController.profileData[index].city,
                          maxLines: 1,overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.normalTitleText
                              .copyWith(color: AppColors.blackColor),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
                width: 200,
                title: "Edit",
                onPressed: () {
                  resumeBuildController.editProfileData(
                      resumeBuildController.profileData[index], index);
                }),
          )
        ],
      ),
    );
  }
}
