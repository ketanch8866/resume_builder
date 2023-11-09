import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:resume_builder/app_routes/app_routes_name.dart';
import 'package:resume_builder/res/app_const.dart';
import 'package:resume_builder/screens/view_model.dart/build_resume_controller.dart';

class BuildResumeScreen extends StatefulWidget {
  const BuildResumeScreen({super.key});

  @override
  State<BuildResumeScreen> createState() => _BuildResumeScreenState();
}

class _BuildResumeScreenState extends State<BuildResumeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> drawerWidget(BuildResumeController controller) {
    return controller.drawerList.map((e) {
      return ListTile(
        onTap: () {
          controller.setBody(controller.drawerList
              .indexWhere((element) => e.labelName == element.labelName));
          _scaffoldKey.currentState!.closeDrawer();
        },
        title: Text(e.labelName),
        leading: e.icon,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BuildResumeController>();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(),
        drawer: Drawer(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Get.offNamed(AppRoutesName.homeRoutes);
                  _scaffoldKey.currentState!.closeDrawer();
                },
                title: const Text("Home"),
                leading: const Icon(Icons.home),
              ),
              ...drawerWidget(controller)
            ],
          ),
        ),
        body: Obx(() => controller.status.value == Status.loading
            ? Center(child: LottieBuilder.asset('asset/lottie/loading.json'))
            : controller.status.value == Status.error
                ? const Center(child: Text("Something Went Wrong"))
                : getBody(controller)));
  }

  Widget getBody(BuildResumeController controller) {
    return controller.drawerScreen[controller.selectedDrawerIndex.value];
  }
}
