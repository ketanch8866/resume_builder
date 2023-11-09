import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:resume_builder/res/app_const.dart';
import 'package:resume_builder/res/app_text_style/app_text_style.dart';
import 'package:resume_builder/res/theam/app_colors.dart';
import 'package:resume_builder/screens/view_model.dart/build_resume_controller.dart';

class ViewResumeScreen extends StatefulWidget {
  const ViewResumeScreen({super.key});

  @override
  State<ViewResumeScreen> createState() => _ViewResumeScreenState();
}

class _ViewResumeScreenState extends State<ViewResumeScreen> {
  List<Widget> items = [];
  @override
  void initState() {
    final resumeBuildController = Get.find<BuildResumeController>();

    loaditeam(resumeBuildController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final resumeBuildController = Get.find<BuildResumeController>();
    return Scaffold(
        appBar: AppBar(),
        body: Obx(() {
          if (resumeBuildController.status.value == Status.loading) {
            return Center(
                child: LottieBuilder.asset('asset/lottie/loading.json'));
          } else if (resumeBuildController.status.value == Status.error) {
            return const Center(child: Text("Something Went Wrong"));
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  resumeBuildController.profileData[0].name,
                  style: AppTextStyle.largeTitleBlack
                      .copyWith(color: AppColors.primaryColor),
                ),
                const Divider(
                  color: AppColors.primaryColor,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.greyColor),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: const Icon(Icons.phone,
                                  color: AppColors.secondaryColor),
                              title: Text(
                                resumeBuildController.profileData[0].mobile,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.normalTitleText
                                    .copyWith(color: AppColors.blackColor),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              leading: const Icon(
                                Icons.email,
                                color: AppColors.secondaryColor,
                              ),
                              title: Text(
                                resumeBuildController.profileData[0].email,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.normalTitleText
                                    .copyWith(color: AppColors.blackColor),
                              ),
                            ),
                          )
                        ],
                      ),
                      //
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: const Icon(
                                Icons.link,
                                color: AppColors.secondaryColor,
                              ),
                              title: Text(
                                resumeBuildController
                                    .profileData[0].linkedInUrl,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.normalTitleText
                                    .copyWith(color: AppColors.secondaryColor),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              leading: const Icon(
                                Icons.location_city,
                                color: AppColors.secondaryColor,
                              ),
                              title: Text(
                                resumeBuildController.profileData[0].city,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.normalTitleText
                                    .copyWith(color: AppColors.blackColor),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: CustomButton(
                //       width: 200,
                //       title: "Edit",
                //       onPressed: () {
                //         resumeBuildController.editProfileData(
                //             resumeBuildController.profileData[index], index);
                //       }),
                // )
                Expanded(
                  child: ReorderableListView(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    children: <Widget>[...items],
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final Widget item = items.removeAt(oldIndex);
                        items.insert(newIndex, item);
                      });
                    },
                  ),
                ),
                // careerObjective(resumeBuildController),
                // buildSkillWidget(resumeBuildController, 0),
                // buildExprienceWidget(resumeBuildController),
                // buildEducationWidget(resumeBuildController),
              ],
            );
          }
        }));
  }

  Widget careerObjective(BuildResumeController resumeBuildController) {
    return Column(
      key: Key('0'),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Career Objective  ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            resumeBuildController.careerObjective!.description,
            maxLines: 5,
            style: AppTextStyle.smallBlackText,
          ),
        ),
      ],
    );
  }

  Widget buildExprienceWidget(BuildResumeController resumeBuildController) {
    return Padding(
      key: Key('1'),
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: resumeBuildController.experienceData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: resumeBuildController
                              .experienceData[index].companyName,
                          style: AppTextStyle.titleBlack,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '  (${resumeBuildController.experienceData[index].roll})',
                              style: AppTextStyle.titleBlack,
                            ),
                          ],
                        ),
                      ),
                      Text(
                          "${DateFormat.yM().format(resumeBuildController.experienceData[index].startTime)}-${DateFormat.yM().format(resumeBuildController.experienceData[index].endTime)}")
                    ],
                  ),
                  Text(
                    resumeBuildController.experienceData[index].decription,
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildEducationWidget(BuildResumeController resumeBuildController) {
    return Padding(
      key: Key('2'),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Education  ",
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: resumeBuildController.educationData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        resumeBuildController
                            .educationData[index].univercityName,
                        style: AppTextStyle.titleBlack,
                      ),
                      Text(
                          "${DateFormat.yM().format(resumeBuildController.educationData[index].startTime)}-${DateFormat.yM().format(resumeBuildController.educationData[index].endTime)}")
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: AppColors.blackColor,
                        ),
                      ),
                      Text(
                        resumeBuildController.educationData[index].degree,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: AppColors.blackColor,
                        ),
                      ),
                      Text(
                        resumeBuildController.educationData[index].grade,
                      ),
                    ],
                  )
                ],
              );
            },
          )
        ],
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
    return Padding(
      key: Key('3'),
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
          children: [
            Text(
              "Skills  ",
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
        Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          spacing: 8,
          children: skills(resumeBuildController, 0),
        )
      ]),
    );
  }

  Future<void> loaditeam(BuildResumeController resumeBuildController) async {
    await resumeBuildController.loadAllData().then((value) {
      items = [
        careerObjective(resumeBuildController),
        buildSkillWidget(resumeBuildController, 0),
        buildExprienceWidget(resumeBuildController),
        buildEducationWidget(resumeBuildController),
      ];
    });
  }
}
