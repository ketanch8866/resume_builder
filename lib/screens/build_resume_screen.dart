import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            children: drawerWidget(controller),
          ),
        ),
        body: Obx(() => getBody(controller)));
  }

  Widget getBody(BuildResumeController controller) {
    return controller.drawerScreen[controller.selectedDrawerIndex.value];
  }
}
