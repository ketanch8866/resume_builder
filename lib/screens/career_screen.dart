import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/res/app_text_style/app_text_style.dart';
import 'package:resume_builder/res/custom_widgets/custom_button.dart';
import 'package:resume_builder/res/custom_widgets/custom_textfield.dart';
import 'package:resume_builder/res/theam/app_colors.dart';
import 'package:resume_builder/screens/view_model.dart/build_resume_controller.dart';

class CareerScreen extends StatelessWidget {
  CareerScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final resumeBuildController = Get.find<BuildResumeController>();
    return Scaffold(
        body: GetBuilder<BuildResumeController>(
      builder: (resumeBuildController) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller:
                    resumeBuildController.careerObjectiveController.value,
                prefixIcon: Icons.edit,
                errorText: "",
                hintText: "Enter Career Objective",
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
              child: Center(
                child: CustomButton(
                  width: 100,
                  title: "Save",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      resumeBuildController.setCareerObjective();
                    }
                  },
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "Career Objective  ",
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                resumeBuildController.careerObjectiveController.value.text,
                maxLines: 5,
                style: AppTextStyle.smallBlackText,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
