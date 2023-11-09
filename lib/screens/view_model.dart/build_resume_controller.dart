import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/data/auth/base_auth.dart';
import 'package:resume_builder/data/firestore_database/firestore_database.dart';
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
  HandleFireStoreDataBase _database = HandleFireStoreDataBase();
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode linkFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  RxBool isEdit = false.obs;
  int proDataIndex = -1;
  Rx<Status> _status = Status.loading.obs;
  Rx<Status> get status => _status;
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
  setStatus(Status sta) {
    _status.value = sta;
  }

  setBody(int index) {
    log(" screen index =-=-$index");
    _selectedDrawerIndex.value = index;
  }

  RxList<ProfileData> profileData = <ProfileData>[
    // ProfileData(name: '', email: '', mobile: '', linkedInUrl: '', city: '')
  ].obs;
  String getUid() {
    return BaseAuthenticatiopn.firebaseAuth.currentUser!.uid;
  }

  @override
  void onInit() {
    loadAllData();
    super.onInit();
  }

  loadAllData() async {
    try {
      setStatus(Status.loading);
      await _database
          .getDocData(resumid, getUid(), "ProfileData")
          .then((value) {
        if (value.exists) {
          profileData.add(ProfileData.fromJson(value.data()!));
          nameController.value.text = profileData[0].name;

          emailController.value.text = profileData[0].email;
          mobileController.value.text = profileData[0].mobile;
          linkController.value.text = profileData[0].linkedInUrl;
          addressController.value.text = profileData[0].city;
        }
      });
      await _database
          .getDocData(resumid, getUid(), "CareerObjective")
          .then((value) {
        if (value.exists) {
          careerObjective = CareerData.fromJson(value.data()!);
          careerObjectiveController.value.text = careerObjective!.description;
        }
      });
      await _database.getDocData(resumid, getUid(), "Skills").then((value) {
        if (value.exists) {
          skillList.value = List.from((value.data()!["skill"] as List)
              .map((e) => Skill.fromJson(e))
              .toList());
        }
      });
      await _database.getDocData(resumid, getUid(), "Exprience").then((value) {
        if (value.exists) {
          Experience data = Experience.fromJson(value.data()!);
          experienceData.value = data.data;
        }
      });
      await _database.getDocData(resumid, getUid(), "Education").then((value) {
        if (value.exists) {
          Education data = Education.fromJson(value.data()!);
          educationData.value = data.data;
        }
      });
      setStatus(Status.complited);
    } on FirebaseException catch (e) {
      setStatus(Status.complited);
      throw e;
    }
  }

  setProfileData() {
    ProfileData data = ProfileData(
        id: resumid,
        uid: getUid(),
        name: nameController.value.text,
        email: emailController.value.text,
        mobile: mobileController.value.text,
        linkedInUrl: linkController.value.text,
        city: addressController.value.text);
    profileData[0] = (data);
    _database.createCollection(resumid, getUid(), "ProfileData", data.toJson());
    clearProfileDataTextField();
  }

  setEditedProfileData() {
    profileData[proDataIndex].name = nameController.value.text;
    profileData[proDataIndex].email = emailController.value.text;
    profileData[proDataIndex].mobile = mobileController.value.text;
    profileData[proDataIndex].linkedInUrl = linkController.value.text;
    profileData[proDataIndex].city = addressController.value.text;
    _database.editCollection(profileData[proDataIndex].id, getUid(),
        "ProfileData", profileData[proDataIndex].toJson());
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
  RxList<Skill> skillList = <Skill>[
    Skill(
        // id: resumid,
        // uid: BaseAuthenticatiopn.firebaseAuth.currentUser!.uid,
        skill: "",
        controller: TextEditingController().obs)
  ].obs;
  addSkill() {
    skillList.add(Skill(
        // id: resumid,
        // uid: getUid(),
        skill: "",
        controller: TextEditingController().obs));
  }

  updateSKill(int index) {
    skillList[index].skill = skillList[index].controller.value.text;
    update();
  }

  saveSkill() {
    _database.createCollection(resumid, getUid(), "Skills", {
      "id": resumid,
      "uid": getUid(),
      "skill": skillList.map((element) => element.skill).toList()
    });
  }

  // Exprience page
  Rx<TextEditingController> startDateController = TextEditingController().obs;
  Rx<TextEditingController> endDateController = TextEditingController().obs;
  RxList<ExperienceData> experienceData = <ExperienceData>[
    ExperienceData(
        // id: resumid,
        // uid: BaseAuthenticatiopn.firebaseAuth.currentUser!.uid,
        companyName: "",
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
        // id: resumid,
        // uid: getUid(),
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
    _database.createCollection(resumid, getUid(), "Exprience", {
      "id": resumid,
      "uid": getUid(),
      "data": experienceData.map((element) => element.toJson()).toList()
    });
    update();
  }

  // Education

  Rx<TextEditingController> startDateEduController =
      TextEditingController().obs;
  Rx<TextEditingController> endDateEduController = TextEditingController().obs;
  RxList<EducationData> educationData = <EducationData>[
    EducationData(
        univercityName: '',
        // id: resumid,
        // uid: BaseAuthenticatiopn.firebaseAuth.currentUser!.uid,
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
        // id: resumid,
        // uid: getUid(),
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
    _database.createCollection(resumid, getUid(), "Education", {
      "id": resumid,
      "uid": getUid(),
      "data": educationData.map((element) => element.toJson()).toList()
    });
    update();
  }

  // Career objective
  Rx<TextEditingController> careerObjectiveController =
      TextEditingController().obs;
  CareerData? careerObjective;
  setCareerObjective() {
    careerObjective = CareerData(
      description: careerObjectiveController.value.text,
      id: resumid,
      uid: getUid(),
    );
    _database.createCollection(
        resumid, getUid(), "CareerObjective", careerObjective!.toJson());
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
