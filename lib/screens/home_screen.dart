import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:resume_builder/app_routes/app_routes_name.dart';
import 'package:resume_builder/res/app_const.dart';
import 'package:resume_builder/res/custom_widgets/custom_button.dart';
import 'package:resume_builder/res/custom_widgets/custom_textfield.dart';
import 'package:resume_builder/res/theam/app_colors.dart';
import 'package:resume_builder/screens/view_model.dart/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("HomePage"),
          actions: [
            IconButton(
                onPressed: () {
                  controller.logOut();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Obx(() => Center(
              child: SingleChildScrollView(
                child: controller.status.value == Status.loading
                    ? Center(
                        child: LottieBuilder.asset('asset/lottie/loading.json'))
                    : controller.status.value == Status.error
                        ? const Center(child: Text("Something Went Wrong"))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.allResume.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: ListTile(
                                        onTap: () {
                                          controller.viewResume(index);
                                        },
                                        title: Text(
                                            controller.allResume[index].name),
                                        subtitle: Text(
                                            controller.allResume[index].id),
                                        trailing: IconButton(
                                            onPressed: () {
                                              controller.editResume(index);
                                            },
                                            icon: Icon(Icons.edit)),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              CustomButton(
                                  title: "Build Resume",
                                  onPressed: () {
                                    Get.dialog(Dialog(
                                      child: Card(
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              Text("Resume Name:"),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomTextField(
                                                  controller: controller
                                                      .resumeNameController
                                                      .value,
                                                  prefixIcon: Icons.abc,
                                                  errorText: "",
                                                  hintText: "Enter resume name",
                                                  textInputType:
                                                      TextInputType.name,
                                                  currentFocusNode: FocusNode(),
                                                  validator: (p0) {
                                                    if (p0!.isEmpty) {
                                                      return "This field is required";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                ),
                                              ),
                                              CustomButton(
                                                  width: 100,
                                                  title: "Ok",
                                                  buttonColors: const [
                                                    AppColors.secondaryColor,
                                                    AppColors.primaryColor,
                                                  ],
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      Get.back(
                                                          result: true,
                                                          canPop: true);
                                                      controller.buildResume();
                                                    }
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                                  }),
                              // CustomButton(
                              //     title: "View Resume",
                              //     onPressed: () {
                              //       Get.toNamed(AppRoutesName.viewResumeRoutes);
                              //     }),
                            ],
                          ),
              ),
            )) // GetX<HomeController>(
        //   builder: (controller) {
        //     // return controller.status.value == Status.loading
        //     //     ? const Center(child: CircularProgressIndicator())
        //     //     : controller.status.value == Status.error
        //     //         ? Center(
        //     //             child: Text(
        //     //               "Somethig went wrong",
        //     //               style: AppTextStyle.titleBlack,
        //     //             ),
        //     //           )
        //     //         : Padding(
        //     //             padding: EdgeInsets.symmetric(horizontal: 8.0),
        //     //             child: Column(
        //     //               crossAxisAlignment: CrossAxisAlignment.start,
        //     //               children: [
        //     //                 Text(
        //     //                   "Home",
        //     //                   style: AppTextStyle.titleBlack,
        //     //                 ),
        //     //               ],
        //     //             ),
        //     //           );
        //
        //     return Center(
        //       child: CustomButton(title: "Build Resume", onPressed: () {
        //         Get.offNamed(AppRoutesName.buildResumeRoutes);
        //       }),
        //     );
        //   },
        // )
        );
  }
}
