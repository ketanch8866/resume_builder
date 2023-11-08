import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/res/app_const.dart';
import 'package:resume_builder/res/app_text_style/app_text_style.dart';
import 'package:resume_builder/screens/view_model.dart/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("HomePage"),
        ),
        body: GetX<HomeController>(
          builder: (controller) {
            return controller.status.value == Status.loading
                ? const Center(child: CircularProgressIndicator())
                : controller.status.value == Status.error
                    ? Center(
                        child: Text(
                          "Somethig went wrong",
                          style: AppTextStyle.titleBlack,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Home",
                              style: AppTextStyle.titleBlack,
                            ),
                          ],
                        ),
                      );
          },
        ));
  }
}
