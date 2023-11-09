import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:resume_builder/app_routes/app_routes_name.dart';
import 'package:resume_builder/data/auth/base_auth.dart';
import 'package:resume_builder/data/firestore_database/firestore_database.dart';
import 'package:resume_builder/model/career_model.dart';
import 'package:resume_builder/model/profile_data_model.dart';
import 'package:resume_builder/model/resume_model.dart';
import 'package:resume_builder/res/app_const.dart';

class HomeController extends GetxController {
  Rx<Status> _status = Status.loading.obs;
  Rx<Status> get status => _status;
  RxInt _selectedIndex = 0.obs;
  RxInt get selectedIndex => _selectedIndex;
  Rx<TextEditingController> resumeNameController = TextEditingController().obs;
  HandleFireStoreDataBase _database = HandleFireStoreDataBase();
  @override
  void onInit() {
    getAllResumeData();
    super.onInit();
  }

  setStatus(Status sta) {
    _status.value = sta;
  }

  RxList<Resume> allResume = <Resume>[].obs;
  getAllResumeData() async {
    try {
      setStatus(Status.loading);
      _database.getCollection(getUid(), "AllResume").then((value) {
        for (var i = 0; i < value.docs.length; i++) {
          if (value.docs[i].exists) {
            allResume.add(Resume.fromJson(value.docs[i].data()));
            print(value.docs[i]["id"]);
          }
        }
      });

      setStatus(Status.complited);
    } on FirebaseException catch (e) {
      setStatus(Status.error);
      throw e;
    } catch (e) {
      setStatus(Status.error);
      throw e;
    }
  }

  String getUid() {
    return BaseAuthenticatiopn.firebaseAuth.currentUser!.uid;
  }

  editResume(int index) {
    resumid = allResume[index].id;
    Get.offNamed(AppRoutesName.buildResumeRoutes);
  }
  viewResume(int index) {
    resumid = allResume[index].id;
    Get.offNamed(AppRoutesName.viewResumeRoutes);
  }

  buildResume() async {
    resumid = DateTime.now().toIso8601String();
    await _database.createCollection(resumid, getUid(), "AllResume", {
      "uid": getUid(),
      "id": resumid,
      "name": resumeNameController.value.text
    });
    await _database.createCollection(resumid, getUid(), "CareerObjective",
        CareerData(description: "", uid: getUid(), id: resumid).toJson());
    await _database.createCollection(
        resumid,
        getUid(),
        "ProfileData",
        ProfileData(
                id: resumid,
                uid: getUid(),
                name: '',
                email: '',
                mobile: '',
                linkedInUrl: '',
                city: '')
            .toJson());
    await _database.createCollection(resumid, getUid(), "Skills", {
      "id": resumid,
      "uid": getUid(),
      "skill": [""]
    });
    await _database.createCollection(resumid, getUid(), "Exprience", {
      "id": resumid,
      "uid": getUid(),
      "data": [
        {
          "company_name": '',
          "roll": '',
          "start_time": DateTime.now().toIso8601String(),
          "end_time": DateTime.now().toIso8601String(),
          "decription": "",
        }
      ]
    });
    await _database.createCollection(resumid, getUid(), "Education", {
      "id": resumid,
      "uid": getUid(),
      "data": [
        {
          "univercity_name": "",
          // "uid": uid,
          // "id": id,
          "degree": "",
          "start_time": DateTime.now().toIso8601String(),
          "end_time": DateTime.now().toIso8601String(),
          "grade": "",
        }
      ]
    });
    Get.offNamed(AppRoutesName.buildResumeRoutes);
  }

  logOut() async {
    await BaseAuthenticatiopn.firebaseAuth.signOut();
    Get.offAllNamed(AppRoutesName.loginRoutes);
  }
}
