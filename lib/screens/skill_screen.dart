import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/res/app_text_style/app_text_style.dart';
import 'package:resume_builder/res/custom_widgets/custom_button.dart';
import 'package:resume_builder/res/custom_widgets/custom_textfield.dart';
import 'package:resume_builder/res/theam/app_colors.dart';
import 'package:resume_builder/screens/view_model.dart/build_resume_controller.dart';

class SkillScreen extends StatelessWidget {
  SkillScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final resumeBuildController = Get.find<BuildResumeController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: resumeBuildController.skillList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                onChange: (p0) {
                                  resumeBuildController.updateSKill(index);
                                },
                                controller: resumeBuildController
                                    .skillList[index].controller.value,
                                prefixIcon: Icons.edit,
                                errorText: "",
                                hintText: "Enter Skills",
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
                            IconButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    resumeBuildController.addSkill();
                                  }
                                },
                                icon: const Icon(Icons.add))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              GetBuilder<BuildResumeController>(
                builder: (controller) =>
                    Expanded(child: buildSkillWidget(controller, 0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  title: "Save Data",
                  onPressed: () {
                    resumeBuildController.saveSkill();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> skills(BuildResumeController resumeBuildController, int index) {
    return resumeBuildController.skillList.map((element) {
      if (element.skill.isEmpty) {
        return SizedBox();
      }
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.secondaryBgColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 3,
              backgroundColor: AppColors.blackColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                element.skill,
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  Widget buildSkillWidget(
      BuildResumeController resumeBuildController, int index) {
    return Column(children: [
      Row(
        children: [
          Text(
            "Skills  ",
            style:
                AppTextStyle.titleBlack.copyWith(color: AppColors.primaryColor),
          ),
          const Expanded(
              child: Divider(
            color: AppColors.primaryColor,
            thickness: 2,
          ))
        ],
      ),
      Wrap(
        alignment: WrapAlignment.start,
        direction: Axis.horizontal,
        spacing: 8,
        children: skills(resumeBuildController, 0),
      )
    ]);
  }
}
