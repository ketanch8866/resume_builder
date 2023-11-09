import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resume_builder/res/app_const.dart';
import 'package:resume_builder/res/app_text_style/app_text_style.dart';
import 'package:resume_builder/res/custom_widgets/custom_button.dart';
import 'package:resume_builder/res/custom_widgets/custom_textfield.dart';
import 'package:resume_builder/res/theam/app_colors.dart';
import 'package:resume_builder/res/utils.dart';
import 'package:resume_builder/screens/view_model.dart/build_resume_controller.dart';

class ExperienceScreen extends StatelessWidget {
  ExperienceScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final resumeBuildController = Get.find<BuildResumeController>();
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Text(
                "Experience  ",
                style: AppTextStyle.titleBlack
                    .copyWith(color: AppColors.primaryColor),
              ),
              const Expanded(
                  child: Divider(
                color: AppColors.primaryColor,
                thickness: 2,
              ))
            ],
          ),
          Expanded(
            child: Obx(
              () => Form(
                key: _formKey,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: resumeBuildController.experienceData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              onChange: (p0) {
                                // resumeBuildController.updateSKill(index);
                              },
                              controller: resumeBuildController
                                  .experienceData[index].companyNameController,
                              prefixIcon: Icons.location_city,
                              errorText: "",
                              hintText: "Enter Company Name",
                              textInputType: TextInputType.text,
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              onChange: (p0) {
                                // resumeBuildController.updateSKill(index);
                              },
                              controller: resumeBuildController
                                  .experienceData[index].rollController,
                              prefixIcon: Icons.location_city,
                              errorText: "",
                              hintText: "Enter your roll",
                              textInputType: TextInputType.text,
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              onChange: (p0) {
                                // resumeBuildController.updateSKill(index);
                              },
                              controller: resumeBuildController
                                  .experienceData[index].decriptionController,
                              prefixIcon: Icons.menu_book,
                              errorText: "",
                              hintText: "Enter description",
                              textInputType: TextInputType.text,
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1997),
                                              lastDate: DateTime.now());

                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);

                                        resumeBuildController
                                            .startDateController
                                            .value
                                            .text = formattedDate;
                                      }
                                    },
                                    controller: resumeBuildController
                                        .startDateController.value,
                                    prefixIcon: Icons.date_range,
                                    errorText: "",
                                    hintText: "Select Date",
                                    textInputType: TextInputType.datetime,
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
                                Expanded(
                                  child: CustomTextField(
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: resumeBuildController
                                                      .startDateController
                                                      .value
                                                      .text
                                                      .isNotEmpty
                                                  ? DateTime.parse(
                                                      resumeBuildController
                                                          .startDateController
                                                          .value
                                                          .text)
                                                  : DateTime(1997),
                                              lastDate: DateTime.now());

                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        if (DateTime.parse(resumeBuildController
                                                .startDateController.value.text)
                                            .isAfter(pickedDate)) {
                                          Utils.showScanckBar(
                                              message: "Invalid Date is Picked",
                                              toastType: ToastType.waring);
                                        } else {
                                          resumeBuildController
                                              .endDateController
                                              .value
                                              .text = formattedDate;
                                        }
                                      }
                                    },
                                    controller: resumeBuildController
                                        .endDateController.value,
                                    prefixIcon: Icons.date_range,
                                    errorText: "",
                                    hintText: "Select End Date",
                                    textInputType: TextInputType.datetime,
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
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                  width: Get.width * 0.3,
                                  title: "Edit And Save",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      resumeBuildController.updateExprience(
                                          index,
                                          DateTime.parse(resumeBuildController
                                              .startDateController.value.text),
                                          DateTime.parse(resumeBuildController
                                              .endDateController.value.text));
                                    }
                                  }),
                              CustomButton(
                                  width: Get.width * 0.3,
                                  title: "Add Experience",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      resumeBuildController.addExprience();
                                    }
                                  }),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
