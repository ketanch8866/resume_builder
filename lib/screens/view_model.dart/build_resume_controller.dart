import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/model/career_model.dart';
import 'package:resume_builder/model/education_model.dart';
import 'package:resume_builder/model/exprience_model.dart';
import 'package:resume_builder/screens/education_screen.dart';
import 'package:resume_builder/screens/exp_screen.dart';
import 'package:resume_builder/screens/profile_screen.dart';
import 'package:resume_builder/screens/career_screen.dart';
import 'package:resume_builder/screens/skill_screen.dart';

import '../../model/profile_data_model.dart';
import '../../model/skill_data_model.dart';
import '../../res/app_const.dart';

class BuildResumeController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> linkController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode linkFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  RxBool isEdit = false.obs;
  int proDataIndex = -1;
  List<Widget> drawerScreen = [
    ProfileScreen(),
    CareerScreen(),
    SkillScreen(),
    ExperienceScreen(),
    EducationScreen()
  ];

  List<DrawerList> drawerList = [
    DrawerList(
        icon: const Icon(Icons.person),
        index: DrawerIndex.profile,
        labelName: "Profile"),
    DrawerList(
        icon: const Icon(Icons.account_tree),
        index: DrawerIndex.career,
        labelName: "Career Objective"),
    DrawerList(
        icon: const Icon(Icons.adb_outlined),
        index: DrawerIndex.skill,
        labelName: "Skill"),
    DrawerList(
        icon: const Icon(Icons.access_time_filled),
        index: DrawerIndex.experience,
        labelName: "Experience"),
    DrawerList(
        icon: const Icon(Icons.menu_book),
        index: DrawerIndex.education,
        labelName: "Education"),
  ];
  RxInt _selectedDrawerIndex = 0.obs;

  RxInt get selectedDrawerIndex => _selectedDrawerIndex;

  setBody(int index) {
    log(" screen index =-=-$index");
    _selectedDrawerIndex.value = index;
  }

  RxList<ProfileData> profileData = <ProfileData>[].obs;

  setProfileData() {
    ProfileData data = ProfileData(
        name: nameController.value.text,
        email: emailController.value.text,
        mobile: mobileController.value.text,
        linkedInUrl: linkController.value.text,
        city: addressController.value.text);
    profileData.add(data);
    clearProfileDataTextField();
  }

  setEditedProfileData() {
    ProfileData data = ProfileData(
        name: nameController.value.text,
        email: emailController.value.text,
        mobile: mobileController.value.text,
        linkedInUrl: linkController.value.text,
        city: addressController.value.text);
    profileData[proDataIndex] = data;
    proDataIndex = -1;
    isEdit.value = false;
    clearProfileDataTextField();
  }

  clearProfileDataTextField() {
    nameController.value.text = "";
    emailController.value.text = "";
    mobileController.value.text = "";
    linkController.value.text = "";
    addressController.value.text = "";
  }

  editProfileData(ProfileData editData, int index) {
    proDataIndex = index;
    isEdit.value = true;
    nameController.value.text = editData.name;
    emailController.value.text = editData.email;
    mobileController.value.text = editData.mobile;
    linkController.value.text = editData.linkedInUrl;
    addressController.value.text = editData.city;
  }

// Skill Page
  RxList<Skill> skillList =
      <Skill>[Skill(skill: "", controller: TextEditingController().obs)].obs;
  addSkill() {
    skillList.add(Skill(skill: "", controller: TextEditingController().obs));
  }

  updateSKill(int index) {
    skillList[index].skill = skillList[index].controller.value.text;
    update();
  }

  // Exprience page
  Rx<TextEditingController> startDateController = TextEditingController().obs;
  Rx<TextEditingController> endDateController = TextEditingController().obs;
  RxList<ExperienceData> experienceData = <ExperienceData>[
    ExperienceData(
        companyName: "",
        uid: "",
        roll: "",
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        decription: "",
        companyNameController: TextEditingController(),
        decriptionController: TextEditingController(),
        rollController: TextEditingController())
  ].obs;
  addExprience() {
    experienceData.add(ExperienceData(
        companyName: "",
        uid: "",
        roll: "",
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        decription: "",
        companyNameController: TextEditingController(),
        decriptionController: TextEditingController(),
        rollController: TextEditingController()));
  }

  updateExprience(int index, DateTime start, DateTime end) {
    experienceData[index].companyName =
        experienceData[index].companyNameController.value.text;
    experienceData[index].decription =
        experienceData[index].decriptionController.value.text;
    experienceData[index].roll =
        experienceData[index].rollController.value.text;
    experienceData[index].startTime = start;
    experienceData[index].endTime = end;
    update();
  }

  // Education

  Rx<TextEditingController> startDateEduController =
      TextEditingController().obs;
  Rx<TextEditingController> endDateEduController = TextEditingController().obs;
  RxList<EducationData> educationData = <EducationData>[
    EducationData(
        univercityName: '',
        uid: '',
        degree: '',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        grade: '',
        degreeController: TextEditingController(),
        gradeController: TextEditingController(),
        univercityController: TextEditingController())
  ].obs;
  addEducation() {
    educationData.add(EducationData(
        univercityName: '',
        uid: '',
        degree: '',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        grade: '',
        degreeController: TextEditingController(),
        gradeController: TextEditingController(),
        univercityController: TextEditingController()));
  }

  updateEducation(int index, DateTime start, DateTime end) {
    educationData[index].univercityName =
        educationData[index].univercityController.value.text;
    educationData[index].degree =
        educationData[index].degreeController.value.text;
    educationData[index].grade =
        educationData[index].gradeController.value.text;
    educationData[index].startTime = start;
    educationData[index].endTime = end;
    update();
  }

  // Career objective
  Rx<TextEditingController> careerObjectiveController =
      TextEditingController().obs;
  CareerData? careerObjective;
  setCareerObjective() {
    careerObjective = CareerData(
      description: careerObjectiveController.value.text,
      uid: "",
    );
  
    update();
  }
}

class DrawerList {
  DrawerList({
    this.labelName = '',
    required this.icon,
    required this.index,
    this.isSet = false,
  });

  String labelName;
  Icon icon;
  bool isSet;
  DrawerIndex index;
}
